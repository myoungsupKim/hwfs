package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.util.DateUtil;
import com.hwfs.sc.cmn.defaults.DefaultLocalFoodDAO;
 /**
 * 고객시스템 Interface하는 CustSysInterfaceRedmouse DAO
 * 
 * @ClassName CustSysInterfaceRedmouseMysqlDAO.java
 * @Description CustSysInterfaceRedmouseMysqlDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.12.23.   JHKim        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/custSysInterfaceRedmouseMssqlDAO")
public class CustSysInterfaceRedmouseMssqlDAO extends DefaultLocalFoodDAO {
	
	
	public RecordSet selectProductRedmouseList(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("fm.fms.custSysInterfaceRedmouseMssqlDAO.selectProductRedmouseList", mapParam);
	}
	/**
	 * 고객시스템 Interface(을)를 창고(배송처)정보를 insert 한다.
	 *
	 * @param mapParam
	 * @return String
	 */
	public String RedmouseSelect(Map<String, Object> mapParam) throws Exception{
		return (String)super.queryForObject("fm.fms.custSysInterfaceRedmouseMssqlDAO.selectRedmouse", mapParam, null);
	}
	/**
	 * 고객시스템 Interface(을)를 창고(배송처)정보를 insert/update 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int RedmouseInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.insertRedmouse", mapParam);
	}

	public int RedmouseUpdate(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.updateRedmouse", mapParam);
	}
	
	public int updateRedmouseAll(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.updateRedmouseAll", mapParam);
	}
	
	
	
	/**
	 * 고객시스템 Interface(을)를 상품정보를 select 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public String itemSelect(Map<String, Object> mapParam) throws Exception{
		return (String)super.queryForObject("fm.fms.custSysInterfaceRedmouseMssqlDAO.selectProductRedmouse", mapParam, null);
	}
	/**
	 * 고객시스템 Interface(을)를 상품정보를 insert/update 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int itemInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.insertProductRedmouse", mapParam);
	}
	public int itemUpdate(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.updateProductRedmouse", mapParam);
	}
	public int itemUpdate2(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.updateProductRedmouse2", mapParam);
	}
	public int itemDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.deleteProductRedmouse", mapParam);
	}
	
	
	/**
	 * 고객시스템 Interface(을)를 주문정보2를 select 한다.
	 *
	 * @param mapParam
	 * @return String
	 */
	public String OrderRedmouseSelect(Map<String, Object> mapParam) throws Exception{
		return (String)super.queryForObject("fm.fms.custSysInterfaceRedmouseMssqlDAO.selectOrderRedmouse", mapParam, null);
	}
	/**
	 * 고객시스템 Interface(을)를 주문정보2를 insert/update 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int OrderRedmouseInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.insertOrderRedmouse", mapParam);
	}
	
	public int OrderRedmouseDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.deleteOrderRedmouse", mapParam);
	}
	

	/**
	 * 고객시스템 Interface(을)를 거래내역2정보를 insert/delete 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int tradeInfoDDRedmouseInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.insertTradeInfoDDRedmouse", mapParam);
	}
	public int tradeInfoDDRedmouseDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.deleteTradeInfoDDRedmouse", mapParam);
	}
	
	/**
	 * 고객시스템 Interface(을)를 월 거래내역을 insert/delete 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int tradeInfoMMRedmouseInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.insertTradeInfoMMRedmouse", mapParam);
	}
	public int tradeInfoMMRedmouseDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceRedmouseMssqlDAO.deleteTradeInfoMMRedmouse", mapParam);
	}
}
