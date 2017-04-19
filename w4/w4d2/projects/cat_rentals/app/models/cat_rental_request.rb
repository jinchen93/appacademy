class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: ["PENDING", "APPROVED", "DENIED"],
     message:"Status must be PENDING, APPROVED, DENIED only"}
  validate :overlapping_requests

   belongs_to :cat,
     primary_key: :id,
     foreign_key: :cat_id,
     class_name: "Cat"

  def overlapping_requests
    return errors[:base] << "End date can't be before start date!" if end_date < start_date
    return true if status == "DENIED" || status == "PENDING"

    overlapping_rentals = CatRentalRequest.where(
      "(? BETWEEN start_date AND end_date OR ? BETWEEN start_date AND end_date) AND cat_id = ? AND status = 'APPROVED'",
      start_date,
      end_date,
      cat_id
    ).where.not(id: id)

    overlapping_rentals += CatRentalRequest.where(
      start_date: start_date..end_date,
      end_date: start_date..end_date,
      cat_id: cat_id,
      status: 'APPROVED'
    ).where.not(id: id)

    if overlapping_rentals.empty?
      true
    else
      return errors[:base] << "Overlapping rentals found for this cat!"
    end
  end

  def overlapping_pending_requests
    overlapping_rentals = CatRentalRequest.where(
      "(? BETWEEN start_date AND end_date OR ? BETWEEN start_date AND end_date) AND cat_id = ? AND status = 'PENDING' AND id <> ?",
      start_date,
      end_date,
      cat_id,
      id
    )

    overlapping_rentals += CatRentalRequest.where(start_date: start_date..end_date, end_date: start_date..end_date, cat_id: cat_id, status: 'PENDING').where.not(id: id)
    overlapping_rentals
  end

  def deny!
    self.update_attributes(status: "DENIED")
  end


  def approve!
    if self.overlapping_requests === true
      self.update_attributes(status: "APPROVED")
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

end
