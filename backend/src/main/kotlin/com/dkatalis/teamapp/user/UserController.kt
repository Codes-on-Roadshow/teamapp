package com.dkatalis.teamapp

import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController {
    val users = ArrayList<String>()

    @GetMapping("/users")
    fun getUsers(): List<String> {
        return users
    }

    @PostMapping("/users")
    fun postUser(user: String){
        users.add(user)
    }
}