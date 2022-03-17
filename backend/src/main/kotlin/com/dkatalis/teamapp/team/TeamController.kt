package com.dkatalis.teamapp

import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.GetMapping

@RestController
class TeamController {
    @GetMapping("/teams")
    fun getTeams() = "It's TeamApp"
}