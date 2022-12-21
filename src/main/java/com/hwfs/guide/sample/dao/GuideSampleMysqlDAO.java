package com.hwfs.guide.sample.dao;

import java.util.HashMap;
import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.sc.cmn.defaults.DefaultLocalFoodDAO;


@Repository("/guide/sample/guideSampleMysqlDAO")
public class GuideSampleMysqlDAO extends DefaultLocalFoodDAO {

	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideSampleMysqlDAO.selectList", parameter);
	}

	public int insert(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleMysqlDAO.insert", parameter);
	}

	public int update(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleMysqlDAO.update", parameter);
	}

	public int delete(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleMysqlDAO.delete", parameter);
	}
}
