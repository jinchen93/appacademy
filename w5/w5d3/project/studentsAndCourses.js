function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courseList = [];
}

Student.prototype.name = function() {
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.enroll = function(course) {
  if (!this.courseList.includes(course) && !this.isConflict(course)) {
    this.courseList.push(course);
    course.students.push(this);
  } else {
    throw "This course conflicts with the current courses!";
  }
};


Student.prototype.isConflict = function(course) {
  this.courseList.forEach( enrolledCourse => {
    if (enrolledCourse.conflictsWith(course)) {
      return true;
    }
  });
  return false;
};


Student.prototype.courseLoad = function() {
  let load = {};

  this.courseList.forEach( course => {
    let department = course.department;

    if (load[department] === undefined) {
      load[department] = course.credits;
    } else {
      load[department] += course.credits;
    }
  });

  return load;
};

function Course(name, department, credits, block, days) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.block = block;
  this.days = days;
}

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function(course) {
  if (this.block !== course.block) {
    return false;
  }

  this.days.forEach( day => {
    if (course.days.includes(day)) {
      return true;
    }
  });

  return false;
};
