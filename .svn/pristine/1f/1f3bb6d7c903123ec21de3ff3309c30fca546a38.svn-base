package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralVendorMgntDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 장례식장 업체정보관리하는 FuneralVendorMgnt Service Implementation
 * 
 * @ClassName FuneralVendorMgntServiceImpl.java
 * @Description FuneralVendorMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralVendorMgntService")
public class FuneralVendorMgntServiceImpl extends DefaultServiceImpl implements FuneralVendorMgntService {
	
	/** FuneralVendorMgntDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralVendorMgntDAO")
	private FuneralVendorMgntDAO funeralVendorMgntDAO;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	/**
	 * 장례식장 업체정보관리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectFuneralVendorList(Map<String, Object> mapParam) throws Exception {
		return funeralVendorMgntDAO.selectFuneralVendorList(mapParam);
	}

	/**
	 * 장례식장 업체정보관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveFuneralVendorList(DataSetMap list,  String sabun) throws Exception {
		String curMaxNum = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", sabun);
			//주소 처리
			Map<String, Object> rtn2 = addressService.setAddress(rowData, "currentAddrInfo", sabun);
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				curMaxNum = funeralVendorMgntDAO.selectMaxSeq(rowData).getRecord(0).get("maxNum").toString();
				rowData.put("custCd", curMaxNum);
				insRowCnt += funeralVendorMgntDAO.insertFuneralVendor(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralVendorMgntDAO.updateFuneralVendor(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralVendorMgntDAO.deleteFuneralVendor(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
