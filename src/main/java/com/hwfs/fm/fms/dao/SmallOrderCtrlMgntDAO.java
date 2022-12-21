package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;


@Repository("/fm/fms/smallOrderCtrlMgntDAO")
public class SmallOrderCtrlMgntDAO extends DefaultDAO {
	
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.smallOrderCtrlMgntDAO.selectList", mapParam);
	}

	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.smallOrderCtrlMgntDAO.update", mapParam);
	}
	
	public RecordSet selectCtrlList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.smallOrderCtrlMgntDAO.selectCtrlList", mapParam);
	}
}
