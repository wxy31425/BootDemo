package com.boot.demo.service;

import com.boot.demo.entity.Log;
import com.boot.demo.entity.Role;
import com.boot.demo.service.support.IBaseService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * <p>
 * 系统日志类
 * </p>
 *
 * @author SPPan
 * @since 2016-12-28
 */
public interface ILogService extends IBaseService<Log, Integer> {

    /**
     * 根据关键字查询分页
     * @param searchName
     * @param level
     * @param request
     * @param pageRequest
     * @return
     */
    Page<Log> findAllByLike(String searchName,String level,String request, PageRequest pageRequest);
    /**
     * 添加日志更新日志
     * @param log
     */
    void saveOrUpdate(Log log);
}
