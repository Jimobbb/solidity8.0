// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 结构体
contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }
    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        Car memory lambo = Car({
            model: "lambo",
            year: 1990,
            owner: msg.sender
        });
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("BYD", 2020, msg.sender));

        // 定义在内存中的结构体不能修改删除只能读取
        Car memory _car = cars[0];
        // _car.model;

        // 定义在存储中的结构体可以修改删除
        Car storage _car2 = cars[0];
        _car.year = 1999; // 可以修改
        delete _car.owner;
        delete cars[1];
    }
}