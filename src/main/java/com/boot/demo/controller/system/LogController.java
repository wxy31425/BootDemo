package com.boot.demo.controller.system;

import com.boot.demo.annotation.SysLog;
import com.boot.demo.controller.base.BaseController;
import com.boot.demo.entity.Log;
import com.boot.demo.util.RestResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/admin/log")
public class LogController extends BaseController {

    @GetMapping("list")
    @SysLog("跳转系统日志页面")
    public String list() {
        return "system/log/list";
    }


    @RequiresPermissions("system:log:list")
    @PostMapping("list")
    @ResponseBody
    public Page<Log> list(String searchName,String level,String request) {
         Page<Log> page = logService.findAllByLike(searchName, level,request, getPageRequest());
         return page;
    }


    @RequiresPermissions("system:log:delete")
    @PostMapping(value = "/delete/{id}")
    @ResponseBody
    @SysLog("删除日志数据(单个)")
    public RestResponse delete(@PathVariable Integer id) {
        if(id == null || id == 0){
            return RestResponse.failure("日志ID不能为空");
        }
        logService.delete(id);
        return RestResponse.success("删除成功");
    }

    @RequiresPermissions("system:log:deleteBatch")
    @ResponseBody
    @PostMapping("/batchRemove")
    @SysLog("删除系统用户数据(批量)")
    public RestResponse batchRemove(@RequestParam("ids[]") Integer[] ids) {
        for(Integer id :ids){
            if(id == null || id == 0){
                return RestResponse.failure("日志ID不能为空");
            }
            logService.delete(id);
        }
        return RestResponse.success("删除成功");
    }

}
