package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.util.DateUtil;
import com.hwfs.sc.cmn.defaults.DefaultYfncDAO;
 /**
 * 고객시스템 Interface하는 CustSysInterface DAO
 * 
 * @ClassName CustSysInterfaceDAO.java
 * @Description CustSysInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.12   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/custSysInterfaceMssqlDAO")
public class CustSysInterfaceMssqlDAO extends DefaultYfncDAO {
	
	
	public RecordSet selectProductList(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("fm.fms.custSysInterfaceMssqlDAO.selectProductList", mapParam);
	}
	/**
	 * 고객시스템 Interface(을)를 창고(배송처)정보를 insert 한다.
	 *
	 * @param mapParam
	 * @return String
	 */
	public String subinvSelect(Map<String, Object> mapParam) throws Exception{
		return (String)super.queryForObject("fm.fms.custSysInterfaceMssqlDAO.selectSubinv", mapParam, null);
	}
	/**
	 * 고객시스템 Interface(을)를 창고(배송처)정보를 insert/update 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int subinvInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.insertSubinv", mapParam);
	}

	public int subinvUpdate(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.updateSubinv", mapParam);
	}
	
	public int updateSubinvAll(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.updateSubinvAll", mapParam);
	}
	
	
	
	/**
	 * 고객시스템 Interface(을)를 상품정보를 select 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public String itemSelect(Map<String, Object> mapParam) throws Exception{
		return (String)super.queryForObject("fm.fms.custSysInterfaceMssqlDAO.selectProduct", mapParam, null);
	}
	/**
	 * 고객시스템 Interface(을)를 상품정보를 insert/update 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int itemInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.insertProduct", mapParam);
	}
	public int itemUpdate(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.updateProduct", mapParam);
	}
	public int itemUpdate2(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.updateProduct2", mapParam);
	}
	public int itemUpdateAll(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.updateProductAll", mapParam);
	}
	
	
	/**
	 * 고객시스템 Interface(을)를 주문정보2를 select 한다.
	 *
	 * @param mapParam
	 * @return String
	 */
	public String orderSelect(Map<String, Object> mapParam) throws Exception{
		return (String)super.queryForObject("fm.fms.custSysInterfaceMssqlDAO.selectOrder", mapParam, null);
	}
	/**
	 * 고객시스템 Interface(을)를 주문정보2를 insert/update 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int orderInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.insertOrder", mapParam);
	}
	
	public int orderDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.deleteOrder", mapParam);
	}
	

	/**
	 * 고객시스템 Interface(을)를 거래내역2정보를 insert/delete 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int tradeInfoDDInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.insertTradeInfoDD", mapParam);
	}
	public int tradeInfoDDDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.deleteTradeInfoDD", mapParam);
	}
	
	/**
	 * 고객시스템 Interface(을)를 월 거래내역을 insert/delete 한다.
	 *
	 * @param mapParam
	 * @return int
	 */
	public int tradeInfoMMInsert(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.insertTradeInfoMM", mapParam);
	}
	public int tradeInfoMMDelete(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceMssqlDAO.deleteTradeInfoMM", mapParam);
	}
}
