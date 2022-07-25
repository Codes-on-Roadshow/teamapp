package com.dkatalis.teamapp.team

import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody

@RestController
class TeamController {
    val teams = ArrayList<String>()

    @GetMapping("/teams")
    fun getTeams(): List<String> {
        return teams
    }

    @PostMapping("/teams")
    fun postTeam(@RequestBody team: String) {
        teams.add(team)
    }
}