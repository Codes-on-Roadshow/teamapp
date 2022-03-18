package com.dkatalis.teamapp.pair

import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping

@RestController
class PairController {
    val pairs = ArrayList<ArrayList<String>>()

    @GetMapping("/pairs")
    fun getPairs(): List<List<String>> {
        return pairs
    }

    @PostMapping("/pairs")
    fun postPair(pair: ArrayList<String>){
        pairs.add(pair)
    }
}