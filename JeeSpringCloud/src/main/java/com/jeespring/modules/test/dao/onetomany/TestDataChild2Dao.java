/**
 * * Copyright &copy; 2015-2020 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved..
 */
package com.jeespring.modules.test.dao.onetomany;

import com.jeespring.common.persistence.InterfaceBaseDao;
import org.apache.ibatis.annotations.Mapper;
import com.jeespring.modules.test.entity.onetomany.TestDataChild2;

/**
 * 订票DAO接口
 * @author JeeSpring
 * @version 2018-08-06
 */
@Mapper
public interface TestDataChild2Dao extends InterfaceBaseDao<TestDataChild2> {
	
}