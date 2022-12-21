package com.hwfs.sm.ssi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.ssi.dao.UserUpjangAuthMgntDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사용자별 업장 권한 관리하는 UserUpjangAuthMgnt Service Implementation
 * 
 * @ClassName UserUpjangAuthMgntServiceImpl.java
 * @Description UserUpjangAuthMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.03    유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/ssi/userUpjangAuthMgntService")
public class UserUpjangAuthMgntServiceImpl extends DefaultServiceImpl implements UserUpjangAuthMgntService {
	
	/** UserUpjangAuthMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/userUpjangAuthMgntDAO")
	private UserUpjangAuthMgntDAO userUpjangAuthMgntDAO;
	

	/**
	 * 사용자별 업장 권한 관리 목록을 조회한다.
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
		return userUpjangAuthMgntDAO.selectList(mapParam);
	}
	
	/**
	 * 사업부별 업장 목록을 조회한다.
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
	public RecordSet selectCcList(Map<String, Object> mapParam) throws Exception {
		return userUpjangAuthMgntDAO.selectCcList(mapParam);
	}

	/**
	 * 사용자별 업장 권한 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap inData, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		int cnt = 0;
		Map<String,Object> rowAddData = new HashMap<String,Object>();
		
		rowAddData = inData.get(0);
		rowAddData.put("empNum", rowAddData.get("sabun"));
		
		//사용자별 CC정보 존재하는지 확인
		cnt = userUpjangAuthMgntDAO.selectCnt(rowAddData);
		
		//사용자로 업장CC존재하면 삭제하고 등록하자
		/*if (cnt > 0){
			delRowCnt += userUpjangAuthMgntDAO.delete(rowAddData);
		}*/
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (!"0".equals(rowData.get("chk"))){
				if ("".equals(rowData.get("empNum"))) {
					rowData.put("empNum", inData.getMapValue(0, "sabun"));
					//Insert 처리
					insRowCnt += userUpjangAuthMgntDAO.insert(rowData);
				}
			} else {
				
				if (!"".equals(rowData.get("empNum"))){
					updRowCnt += userUpjangAuthMgntDAO.update(rowData);
				}
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
