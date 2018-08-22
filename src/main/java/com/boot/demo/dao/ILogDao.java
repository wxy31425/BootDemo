package com.boot.demo.dao;

import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.Log;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ILogDao extends IBaseDao<Log, Integer> {
    Page<Log> findAllByUserNameContaining(String searchName,Pageable pageable);
    Page<Log> findAllByHttpMethodContaining(String level,Pageable pageable);
    Page<Log> findAllByTypeContaining(String request,Pageable pageable);
    Page<Log> findAllByHttpMethodContainingAndTypeContaining(String level,String request,Pageable pageable);
    Page<Log> findAllByUserNameContainingAndTypeContaining(String searchName,String request,Pageable pageable);
    Page<Log> findAllByUserNameContainingAndHttpMethodContaining(String searchName,String level,Pageable pageable);
    Page<Log> findAllByUserNameOrHttpMethodOrTypeContaining(String searchName,String level,String request,Pageable pageable);
    Page<Log> findAllByUserNameAndHttpMethodAndTypeContaining(String searchName,String level,String request,Pageable pageable);
}
