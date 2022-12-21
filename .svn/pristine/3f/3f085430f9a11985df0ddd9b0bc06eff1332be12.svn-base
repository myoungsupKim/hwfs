package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.fm.fms.dao.CustSysInterfaceDAO;
import com.hwfs.fm.fms.dao.CustSysInterfaceMssqlDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 고객시스템 Interface하는 CustSysInterface Service Implementation
 * 
 * @ClassName CustSysInterfaceServiceImpl.java
 * @Description CustSysInterfaceServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.12    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/custSysInterfaceService")
public class CustSysInterfaceServiceImpl extends DefaultServiceImpl implements CustSysInterfaceService {
	
	
	/** CustSysInterfaceDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceDAO")
	private CustSysInterfaceDAO custSysInterfaceDAO;
	
	/** CustSysInterfaceMssqlDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceMssqlDAO")
	private CustSysInterfaceMssqlDAO custSysInterfaceMssqlDAO;

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	/**
	 * 고객시스템 Interface 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		
		if(mapParam.get("schType").equals("tpg_subinv"))
			return custSysInterfaceDAO.selectSubinv(mapParam);
		else if(mapParam.get("schType").equals("tpg_item"))
			return custSysInterfaceDAO.selectItem(mapParam);
		else if(mapParam.get("schType").equals("tpg_order"))
			return custSysInterfaceDAO.selectOrder(mapParam);
		else if(mapParam.get("schType").equals("tpg_trans"))
			return custSysInterfaceDAO.selectTrans(mapParam);
		else if(mapParam.get("schType").equals("tpg_result"))
			return custSysInterfaceDAO.selectResult(mapParam);
		else if(mapParam.get("schType").equals("tpg_order2"))
			return custSysInterfaceDAO.selectOrder2(mapParam);
		else if(mapParam.get("schType").equals("tpg_trans2"))
			return custSysInterfaceDAO.selectTrans2(mapParam);
		else if(mapParam.get("schType").equals("tpg_transMonth"))
			return custSysInterfaceDAO.selectTransMonth(mapParam);
		else if(mapParam.get("schType").equals("tpg_item2"))
			return custSysInterfaceMssqlDAO.selectProductList(mapParam);
		
		return null;
	}

	/**
	 * 고객시스템 Interface DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			insRowCnt += custSysInterfaceDAO.insert(rowData);
			//Insert 처리
			/*
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += custSysInterfaceDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += custSysInterfaceDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += custSysInterfaceDAO.delete(rowData);
			}
			*/
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}



	@Resource(name ="transactionManagerYfnc")
	private PlatformTransactionManager txManger;
	
	@Transactional(propagation=Propagation.REQUIRED)
	public int saveListYfnc(DataSetMap list,Map<String, Object>  search) throws Exception{
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int delFlag = 0;
		//Transaction
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		//이연 Fnc 운영 & 개발 체크 .
		String mode = super.propertiesService.getString("fnc.mode");
		logger.debug("search : " + search.toString());
		try{
			for(int i=0; i < list.size(); i++){
				Map<String, Object> rowData = list.get(i);
				logger.debug("rowData : " + rowData.toString());
				if(("P".equals(search.get("schGubun").toString()) && "1".equals(rowData.get("chk").toString())) 
				 || "A".equals(search.get("schGubun").toString())){
					rowData.put("ifJobid", search.get("schGubun")+DateUtil.getYyyymmddhhmmss());
					rowData.put("mod", mode);
					logger.debug("schType : " + search.get("schType").toString());
					if("tpg_subinv".equals(search.get("schType").toString())){//창고(배송처)정보
						//if("A".equals(search.get("schGubun").toString()) && i == 0){
							//custSysInterfaceMssqlDAO.updateSubinvAll(rowData);//모든 창고 D로 업데이트.
						//}
						
						String key = custSysInterfaceMssqlDAO.subinvSelect(rowData);
						if(!"".equals(key) && key != null){
							updRowCnt += custSysInterfaceMssqlDAO.subinvUpdate(rowData);
						}else{
							insRowCnt += custSysInterfaceMssqlDAO.subinvInsert(rowData);
						}
					}else if("tpg_item".equals(search.get("schType").toString())){//상품정보
						//if("A".equals(search.get("schGubun").toString()) && i == 0){
							//custSysInterfaceMssqlDAO.itemUpdateAll(rowData);//모든 상품정보 D로 업데이트.
						//}
						
						String key = custSysInterfaceMssqlDAO.itemSelect(rowData);
						logger.debug("key : " + key);
						if(!"".equals(key) && key != null){
							updRowCnt += custSysInterfaceMssqlDAO.itemUpdate(rowData);
						}else{
							insRowCnt += custSysInterfaceMssqlDAO.itemInsert(rowData);
						}
//					}else if("tpg_order".equals(search.get("schType").toString())){//주문정보
						//insRowCnt += custSysInterfaceMssqlDAO.orderInsert(rowData);
//					}else if("tpg_trans".equals(search.get("schType").toString())){//거래내역
						//insRowCnt += custSysInterfaceMssqlDAO.insert(rowData);
					}else if("tpg_order2".equals(search.get("schType").toString())){//주문정보2
						if(delFlag == 0 && i ==0){
							logger.debug("delFlag : " + delFlag + "  ,                " + i);
							delFlag += custSysInterfaceMssqlDAO.orderDelete(rowData);
						}
						insRowCnt += custSysInterfaceMssqlDAO.orderInsert(rowData);
					}else if("tpg_trans2".equals(search.get("schType").toString())){//거래내역2
						if(delFlag == 0 && i ==0){
							delFlag += custSysInterfaceMssqlDAO.tradeInfoDDDelete(rowData);
						}
						insRowCnt += custSysInterfaceMssqlDAO.tradeInfoDDInsert(rowData);
					}else if("tpg_transMonth".equals(search.get("schType").toString())){//월 거래내역
						if(delFlag == 0 && i ==0){
							delFlag += custSysInterfaceMssqlDAO.tradeInfoMMDelete(rowData);
						}
						insRowCnt += custSysInterfaceMssqlDAO.tradeInfoMMInsert(rowData);
					}
				}
			}
			//commit
			txManger.commit(txStatus);
		}catch( Exception e){
			//rollback
			txManger.rollback(txStatus);
			throw e;
		}
		return insRowCnt + updRowCnt + delRowCnt;	
	}
	
}
