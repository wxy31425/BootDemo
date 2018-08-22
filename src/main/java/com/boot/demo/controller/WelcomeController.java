package com.boot.demo.controller;

import com.boot.demo.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/welcome")
public class WelcomeController extends BaseController {

	@GetMapping("index")
	public String index(){
		return "welcome";
	}
	

}
