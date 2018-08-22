package com.boot.demo.dao;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IUserDao extends IBaseDao<User, Integer> {
	User findByUserName(String username);
	Page<User> findAllByNickNameContaining(String searchText, Pageable pageable);

	@Query(value = "select count(*) from tb_user where user_name=:userName",nativeQuery = true)
	int selectCountUserName(@Param("userName") String userName);

	@Query(value = "select count(*) from tb_user where email=:email",nativeQuery = true)
	int selectCountEmail(@Param("email") String email);

	@Query(value = "select count(*) from tb_user where telephone=:telephone",nativeQuery = true)
	int selectCountTelephone(@Param("telephone") String telephone);



}
