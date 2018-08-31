package com.casic.test.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import com.casic.core.test.BaseMybatisTest;
import com.casic.platform.saas.role.SaasRole;

public class SaasRoleMybatisTest extends BaseMybatisTest{
    @Test
    public void testGetbyUserIdAndTenantId() {  
    	String statement = "getByTenantIdAndPlatformPublicRole";
		
    	//声明变量
    	Map<String,Object> params = new HashMap<String,Object>();
		params.put("tenantId", 100);
		
        SqlSession sqlSession = getSessionFactory().openSession(); 
        List<SaasRole> roles = sqlSession.selectList(statement, params);
        System.out.println(roles);
    }  
}
