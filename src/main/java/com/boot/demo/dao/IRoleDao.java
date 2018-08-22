package com.boot.demo.dao;

import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.Role;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IRoleDao extends IBaseDao<Role, Integer> {
	Page<Role> findAllByNameContainingOrDescriptionContaining(String searchText1, String searchText2, Pageable pageable);

	@Query(value = "select count(*) from tb_role where name=:name",nativeQuery = true)
	int selectCountRoleName(@Param("name") String name);


}
