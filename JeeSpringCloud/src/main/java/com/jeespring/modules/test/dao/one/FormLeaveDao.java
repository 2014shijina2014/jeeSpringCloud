/**
 * * Copyright &copy; 2015-2020 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved..
 */
package com.jeespring.modules.test.dao.one;

import com.jeespring.common.persistence.InterfaceBaseDao;
import org.apache.ibatis.annotations.Mapper;
import com.jeespring.modules.test.entity.one.FormLeave;

/**
 * 员工请假DAO接口
 * @author JeeSpring
 * @version 2018-08-03
 */
@Mapper
public interface FormLeaveDao extends InterfaceBaseDao<FormLeave> {
	
}