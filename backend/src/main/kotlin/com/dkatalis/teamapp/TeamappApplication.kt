package com.dkatalis.teamapp

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class TeamappApplication

fun main(args: Array<String>) {
	runApplication<TeamappApplication>(*args)
}
