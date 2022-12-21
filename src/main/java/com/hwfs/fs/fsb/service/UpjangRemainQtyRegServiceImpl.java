package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsb.dao.UpjangRemainQtyRegDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사업장기준정보 저장권한 관리 UpjangRemainQtyRegServiceImpl Service Implementation
 * 
 * @ClassName UpjangRemainQtyRegServiceImpl.java
 * @Description UpjangRemainQtyRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.05.20    kihoon        최초생성
 * </pre>
 * @author 한화시스템/ICT : kihoon
 * @since 2019.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2019 by HANWHA CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsb/upjangRemainQtyRegService")
public class UpjangRemainQtyRegServiceImpl extends DefaultServiceImpl implements UpjangRemainQtyRegService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** UpjangRemainQtyRegDAO Bean 생성 */
	@Resource(name = "/fs/fsb/upjangRemainQtyRegDAO")
	private UpjangRemainQtyRegDAO upjangRemainQtyRegDAO;
	
	
	/**
	 * 업장 기준정보 권한 목록 조회
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return upjangRemainQtyRegDAO.selectList(mapParam);
	}
	
	
	
	/**
	 * 업장 기준정보 권한 목록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		

		for (int i = 0 ; i < list.size() ; i++) {
			
			Map<String, Object> rowData = list.get(i);
			rowData.put("loginSabun", loginDTO.getSabun());
			
			logger.debug("rowData = " + rowData.toString());
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += upjangRemainQtyRegDAO.insertUpjangRemainQtyReg(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				delRowCnt += upjangRemainQtyRegDAO.deleteUpjangRemainQtyReg(rowData);
				
				updRowCnt += upjangRemainQtyRegDAO.updateUpjangRemainQtyReg(rowData);
			}
			
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += upjangRemainQtyRegDAO.deleteUpjangRemainQtyReg(rowData);
			}
		}
				
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
