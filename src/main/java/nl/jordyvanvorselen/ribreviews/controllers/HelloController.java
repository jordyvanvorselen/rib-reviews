package nl.jordyvanvorselen.ribreviews.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @RequestMapping("/")
    public String getGreeting() {
        return "Hello world!!!";
    }

}
