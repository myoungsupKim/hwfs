package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.util.DateUtil;
import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;
 /**
 * 모아담시스템 데이터처리하는 MoadamSysInterfaceSql DAO
 * 
 * @ClassName MoadamSysInterfaceSqlDAO.java
 * @Description MoadamSysInterfaceSqlDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.10.07   hye.jin94        최초생성
 * </pre>
 * @author hye.jin94
 * @since 2021.10.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/moadamSysInterfaceSqlDAO")
public class MoadamSysInterfaceSqlDAO extends DefaultDAO {
	
	/**
	 * 고객시스템 Interface(을)를 주문정보를 insert/update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateOrderList(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.MoadamSysInterfaceSqlDAO.updateOrderList", parameter);
	}
	
	public int[] updateOrderList2(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fmo.MoadamSysInterfaceSqlDAO.updateOrderList2", listParam);
	}
	
	/**
	 * 모아담 주문정보 조회
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectTargetList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.MoadamSysInterfaceSqlDAO.selectTargetList", mapParam);
	}

	/**
	 * 모아담 사업장 디데이를 조회한다.
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectDdayList(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("fm.fmo.MoadamSysInterfaceSqlDAO.selectDdayList", mapParam);
	}
	
	/**
	 * 모아담 업장리스트를 조회한다.
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("fm.fmo.MoadamSysInterfaceSqlDAO.selectUpjangList", mapParam);
	}
	
	
}
