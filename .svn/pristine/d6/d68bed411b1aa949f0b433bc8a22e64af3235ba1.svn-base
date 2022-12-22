package com.hwfs.sc.sca.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 권한을 부여하는 AuthMappingMgmt Service Interface
 *
 * @ClassName AuthMappingMgmtService.java
 * @Description AuthMappingMgmtService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.17
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AuthMappingMgmtService {

	/**
	 * 권한 부여 목록을 조회한다.
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
	RecordSet selectAuthList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 미등록 CC와 등록된 CC목록을 조회한다.(권한별 CC관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, RecordSet> selectAuthDeptList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * CC목록을 조회한다.(CC별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	RecordSet selectDeptAuthCcList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 미등록 권한목록과 등록된 권한목록을 조회한다.(CC별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, RecordSet> selectDeptAuthList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 권한 부여 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	int saveDeptRoleList(DataSetMap list) throws Exception;

	/**
	 * 미등록 사용자군과 등록된 사용자권목록을 조회한다.(권한별 사용자군관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, RecordSet> selectAuthCustList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 권한 부여 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	int saveUserGroupRoleList(DataSetMap list) throws Exception;

	/**
	 * 사용자군을 조회한다.(사용자군별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	RecordSet selectCustAuthUserGroupList(Map<String, Object> mapParam)
			throws Exception;

	/**
	 * 미등록 권한목록과 등록된 권한목록을 조회한다.(사용자군별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, RecordSet> selectCustAuthList(Map<String, Object> mapParam)
			throws Exception;
}
