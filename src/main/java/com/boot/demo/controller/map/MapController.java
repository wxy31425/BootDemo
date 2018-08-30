package com.boot.demo.controller.map;

import com.boot.demo.annotation.SysLog;
import com.boot.demo.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/map/ivmap")
public class MapController extends BaseController {

    @GetMapping("list")
    @SysLog(" 跳转地图界面")
    public String list (){
        return "map/ivMap";
    }
}
