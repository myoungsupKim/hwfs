package com.hwfs.ms.mmb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mmb.dao.LoginSessionUpdateDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 로그인관리자 디바이스 정보 갱신하는 LoginSessionUpdate Service Implementation
 * 
 * @ClassName LoginSessionUpdateServiceImpl.java
 * @Description LoginSessionUpdateServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.04.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mmb/loginSessionUpdateService")
public class LoginSessionUpdateServiceImpl extends DefaultServiceImpl implements LoginSessionUpdateService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LoginSessionUpdateDAO Bean 생성 */
	@Resource(name = "/ms/mmb/loginSessionUpdateDAO")
	private LoginSessionUpdateDAO loginSessionUpdateDAO;
	

	/**
	 * 로그인관리자 디바이스 정보 갱신 목록을 조회한다.
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
		return loginSessionUpdateDAO.selectList(mapParam);
	}

	/**
	 * 로그인관리자 디바이스 정보 갱신 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int cnt = 0;
		
		logger.debug("list.size() >>>" +list.size());
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
		    // 기존등록여부 CHECK 
			cnt = loginSessionUpdateDAO.selectAppCnt(rowData);
					
			// 디바이스정보, 자동로그인여부, 아이디저장여부 및 PUSH알림 수신여부 INSERT/UPDTE 처리
			if (cnt==0) {
				insRowCnt += loginSessionUpdateDAO.insert(rowData);
			}else{
				updRowCnt += loginSessionUpdateDAO.update(rowData);
			}				
		}
				
		return insRowCnt + updRowCnt;
	}
	
	/**
	 * 로그인관리자 디바이스 정보 갱신 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveSettingList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		logger.debug("list.size() >>>" +list.size());
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
		    updRowCnt += loginSessionUpdateDAO.updateSetting(rowData);
							
		}
				
		return updRowCnt;
	}
}
