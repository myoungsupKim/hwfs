package com.hwfs.ma.map.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

@Repository("/ma/map/masStAccountDAO")
public class MasStAccountDAO extends DefaultDAO {
	
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ma.map.masStAccountDAO.selectList", mapParam);
    }

	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.map.masStAccountDAO.insert", mapParam);
	}

	public int update(Map<String, Object> mapParam) throws Exception {
		/*
        System.out.println("acctcd:" + mapParam.get("acctcd"));
        System.out.println("acctnm1:" + mapParam.get("acctnm1"));
		*/
		return super.update("ma.map.masStAccountDAO.update", mapParam);
	}
	
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.map.masStAccountDAO.delete", mapParam);
	}
	
}