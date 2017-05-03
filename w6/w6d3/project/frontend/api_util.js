const APIUtil = {
  followUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: 'JSON'
    })
  ),

  unfollowUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'JSON'
    })
  ),

  searchUsers: queryVal => (
    $.ajax({
      url: '/users/search',
      data: { query: queryVal },
      dataType: 'JSON'
    })
  )

};

module.exports = APIUtil;
