// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    struct Book {
        string title;
        string author;
        uint id;
        address owner;
    }

    Book public book;
    Book[] public books;
    mapping(address => Book[]) public booksByOwner;

    function operations() external {
        // 结构体直接按照字段顺序，进行初始化
        Book memory book1 = Book('Learn Java', 'codebaoku.com', 1, msg.sender);

        // 结构体按照字段名，进行初始化
        Book memory book2 = Book({title: 'Learn JS', author: 'codebaoku.com', id: 2, owner: msg.sender});

        // 结构体按照默认值，进行初始化
        Book memory book3;
        book3.id = 3;
        book3.title = 'Learn C';
        book3.author = 'codebaoku.com';
        book3.owner = msg.sender;

        // 结构体数组操作
        books.push(book1);
        books.push(book2);
        books.push(book3);

        // 结构体状态变量操作
        Book storage _book = books[0];
        delete _book.id;
        delete books[0];
        _book.id = 100;
    }
}