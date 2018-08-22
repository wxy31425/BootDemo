package com.boot.demo.service.impl;

import com.boot.demo.dao.ILogDao;
import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.Log;
import com.boot.demo.service.ILogService;
import com.boot.demo.service.support.impl.BaseServiceImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * <p>
 * 系统日志服务类
 * </p>
 *
 * @since 2016-12-28
 */
@Service
public class LogServiceImpl  extends BaseServiceImpl<Log, Integer> implements ILogService {

    @Autowired
    private ILogDao logDao;

    @Override
    public IBaseDao<Log, Integer> getBaseDao() {
        return this.logDao;
    }


    @Override
    public Page<Log> findAllByLike(String searchName,String level,String request, PageRequest pageRequest) {
        if (StringUtils.isBlank(searchName) && StringUtils.isBlank(level) && StringUtils.isBlank(request)) {
            searchName = "";
            request = "";
            level = "";
            return logDao.findAllByUserNameOrHttpMethodOrTypeContaining(searchName, level, request, pageRequest);
        } else if (StringUtils.isBlank(level) && StringUtils.isBlank(request)) {
            level = "";
            request = "";
            return logDao.findAllByUserNameContaining(searchName, pageRequest);
        } else if (StringUtils.isBlank(searchName) && StringUtils.isBlank(request)) {
            searchName = "";
            request = "";
            return logDao.findAllByHttpMethodContaining(level, pageRequest);
        } else if (StringUtils.isBlank(searchName) && StringUtils.isBlank(level)) {
            searchName = "";
            level = "";
            return logDao.findAllByTypeContaining(request, pageRequest);
        } else if (StringUtils.isBlank(searchName)) {
            searchName = "";
            return logDao.findAllByHttpMethodContainingAndTypeContaining(level, request, pageRequest);
        } else if (StringUtils.isBlank(level)) {
            level = "";
            return logDao.findAllByUserNameContainingAndTypeContaining(searchName, request, pageRequest);
        } else if(StringUtils.isBlank(request)) {
            request = "";
            return logDao.findAllByUserNameContainingAndHttpMethodContaining(searchName, level, pageRequest);
        } else {
            return logDao.findAllByUserNameAndHttpMethodAndTypeContaining(searchName, level,request,pageRequest);
        }
    }

    @Override
    public void saveOrUpdate(Log log) {
        log.setCreateTime(new Date());
        save(log);
    }
}
