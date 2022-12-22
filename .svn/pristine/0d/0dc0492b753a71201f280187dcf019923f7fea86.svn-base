package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주소검색을하는 AddrSearch DAO
 *
 * @ClassName AddrSearchDAO.java
 * @Description AddrSearchDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.09
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/addrSearchDAO")
public class AddrSearchDAO extends DefaultDAO {

	/**
	 * 도로명 주소 검색 조건에 대한 시도 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @return
	 */
	public RecordSet selectSidoList() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.addrSearchDAO.selectSidoList", parameter);
	}

	/**
	 * 도로명 주소 검색 조건에 대한 시구군 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGugunList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.addrSearchDAO.selectGugunList", parameter);
	}

	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRoadList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.addrSearchDAO.selectRoadList", parameter);
	}

	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectJibunList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.addrSearchDAO.selectJibunList", parameter);
	}

	/**
	 * 주소정보를 처리한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> setAddress(Map<String, Object> parameter) throws Exception {
		SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_ADDR_INFO", Types.VARCHAR),
			    new SqlParameter("V_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SCC_ADDR_PRO", sqlParameter, parameter);
	}

}
