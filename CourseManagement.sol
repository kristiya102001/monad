// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract CourseManagement {
    struct Course {
        string name;
        string description;
        uint256 duration;
        address instructor;
        bool isActive;
    }

    mapping(uint => Course) public courses;
    uint public courseCount;

    function addCourse(string memory name, string memory description, uint256 duration) public {
        courses[courseCount] = Course({
            name: name,
            description: description,
            duration: duration,
            instructor: msg.sender,
            isActive: true
        });
        courseCount++;
    }

    function updateCourse(uint courseId, string memory name, string memory description, uint256 duration) public {
        require(courseId < courseCount, "Course does not exist.");
        require(courses[courseId].instructor == msg.sender, "Not the instructor of the course.");
        courses[courseId].name = name;
        courses[courseId].description = description;
        courses[courseId].duration = duration;
    }

    function deactivateCourse(uint courseId) public {
        require(courseId < courseCount, "Course does not exist.");
        require(courses[courseId].instructor == msg.sender, "Not the instructor of the course.");
        courses[courseId].isActive = false;
    }

    function getCourse(uint courseId) public view returns (string memory name, string memory description, uint256 duration, address instructor, bool isActive) {
        require(courseId < courseCount, "Course does not exist.");
        Course memory course = courses[courseId];
        return (course.name, course.description, course.duration, course.instructor, course.isActive);
    }
}