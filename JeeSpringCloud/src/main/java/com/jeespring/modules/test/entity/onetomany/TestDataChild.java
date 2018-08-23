/**
 * * Copyright &copy; 2015-2020 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved..
 */
package com.jeespring.modules.test.entity.onetomany;

import com.jeespring.modules.sys.entity.Area;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jeespring.common.persistence.AbstractBaseEntity;
import com.jeespring.common.utils.excel.annotation.ExcelField;
import com.jeespring.modules.sys.utils.DictUtils;

/**
 * 订票Entity
 * @author JeeSpring
 * @version 2018-08-06
 */
public class TestDataChild extends AbstractBaseEntity<TestDataChild> {
	
	private static final long serialVersionUID = 1L;
	private com.jeespring.modules.sys.entity.Area start;		// 出发地
	private com.jeespring.modules.sys.entity.Area end;		// 目的地
	private Double price;		// 代理价格
	private TestDataMain  testDataMain;		// 业务主表ID 父类testDataMain.id
	
	public TestDataChild() {
		super();
	}

	public TestDataChild(String id){
		super(id);
	}

	public TestDataChild(TestDataMain testDataMain){
		this.testDataMain = testDataMain;
	}

	@NotNull(message="出发地不能为空")
				@ExcelField(title="出发地", fieldType=Area.class, value="start.name", align=2, sort=1)
	public Area getStart() {
		return start;
	}

	public void setStart(Area start) {
		this.start = start;
	}
	@NotNull(message="目的地不能为空")
				@ExcelField(title="目的地", fieldType=Area.class, value="end.name", align=2, sort=2)
	public Area getEnd() {
		return end;
	}

	public void setEnd(Area end) {
		this.end = end;
	}
	@NotNull(message="代理价格不能为空")
				@ExcelField(title="代理价格", align=2, sort=3)
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}


	@Length(min=0, max=64, message="业务主表ID长度必须介于 0 和 64 之间")
	@JsonIgnore
	@JSONField(serialize=false)
	public TestDataMain getTestDataMain() {
		return testDataMain;
	}

	public void setTestDataMain(TestDataMain testDataMain) {
		this.testDataMain = testDataMain;
	}
	
}