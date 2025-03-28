// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract LibraryLending {
    struct Book {
        string title;
        string author;
        bool isAvailable;
    }

    struct BorrowRecord {
        address borrower;
        uint256 borrowDate;
        bool returned;
    }

    mapping(uint => Book) public books;
    mapping(uint => BorrowRecord[]) public borrowRecords;
    uint public bookCount;

    function addBook(string memory title, string memory author) public {
        books[bookCount] = Book({
            title: title,
            author: author,
            isAvailable: true
        });
        bookCount++;
    }

    function borrowBook(uint bookId) public {
        require(bookId < bookCount, "Book does not exist.");
        require(books[bookId].isAvailable, "Book is not available.");

        books[bookId].isAvailable = false;
        borrowRecords[bookId].push(BorrowRecord({
            borrower: msg.sender,
            borrowDate: block.timestamp,
            returned: false
        }));
    }

    function returnBook(uint bookId) public {
        require(bookId < bookCount, "Book does not exist.");
        require(borrowRecords[bookId].length > 0, "No borrow records found for this book.");
        require(borrowRecords[bookId][borrowRecords[bookId].length - 1].borrower == msg.sender, "Not the borrower of this book.");
        require(!borrowRecords[bookId][borrowRecords[bookId].length - 1].returned, "Book already returned.");

        books[bookId].isAvailable = true;
        borrowRecords[bookId][borrowRecords[bookId].length - 1].returned = true;
    }

    function getBook(uint bookId) public view returns (string memory title, string memory author, bool isAvailable) {
        require(bookId < bookCount, "Book does not exist.");
        Book memory book = books[bookId];
        return (book.title, book.author, book.isAvailable);
    }

    function getBorrowRecords(uint bookId) public view returns (BorrowRecord[] memory) {
        require(bookId < bookCount, "Book does not exist.");
        return borrowRecords[bookId];
    }
}