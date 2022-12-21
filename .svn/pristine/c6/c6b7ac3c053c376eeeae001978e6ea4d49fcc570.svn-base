package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 사용자를 관리하는 UserMngt Service Interface
 *
 * @ClassName UserMngtService.java
 * @Description UserMngtService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.27
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UserMngtService {

	/**
	 * 등록된 사용자가 있는지를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	RecordSet selectExistsUser(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 사용자 권한레벨정보 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	RecordSet selectAuthLevelList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 사용자 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> select(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 사용자 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectHist(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 사용자 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	Map<String, String> save(DataSetMap list, DataSetMap authLevelList) throws Exception;

	/**
	 * 사용자권한(등록/미등록) 목록을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectUserAuth(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 사용자 권한정보를 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int saveUserAuth(DataSetMap list) throws Exception;

	/**
	 * 사용자 예외권한 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	RecordSet selectExptAuthList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 사용자 예외권한정보를 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int saveExptAuth(DataSetMap list) throws Exception;

	/**
	 * 게시판 권한(등록/미등록) 목록을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectBbsAuthList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 게시판 권한정보를 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int saveBbsAuth(DataSetMap list) throws Exception;

	/**
	 * 복수업장을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	RecordSet selectDualUpjang(Map<String, Object> mapParam) throws Exception;

	/**
	 * 복수업장을 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int saveDualUpjang(DataSetMap list) throws Exception;

	int saveUnLock(DataSetMap master) throws Exception;

	String saveClearPwd(Map<String, Object> parameter) throws Exception;
}
