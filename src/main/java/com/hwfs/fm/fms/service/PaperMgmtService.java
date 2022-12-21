package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;



 /**
 * 관련서류 및 첨부파일을 관리하는 PaperMgmt Service Interface
 * 
 * @ClassName PaperMgmtService.java
 * @Description PaperMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    최성연        최초생성
 *   
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PaperMgmtService {

	/**
	 * 서류관리 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectMigList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectPath(Map<String, Object> mapParam) throws Exception;

	/**
	 * 문서정보를 조회한다.(1 Row)
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectDoc(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 첨부파일 존재여부를 조회한다
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 조회건수
	 * @throws Exception
	*/
	int selectMigFile(DataSetMap list) throws Exception;

	
	/**
	 * 문서정보의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다. (DTO)
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param list, listFile
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리결과
	 * @throws Exception
	*/
	String saveDoc(DataSetMap list, DataSetMap listFile) throws Exception;
	String saveMig(DataSetMap list, DataSetMap listFile) throws Exception;
	
	
	
	
    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 global.filerepository.path가 된다.
     * </pre>
     * 
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String saveFile(DataSetMap listFile, String relPath, boolean encYn) throws Exception;

	/**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다. 
     * </pre>
     * 
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String saveFile(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn) throws Exception;

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다. 
     * - useOrgnlNmYn가 true이면 원본 파일명을 유지 
     * </pre>
     * 
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @param useOrgnlNmYn 파일저장 시 원본 파일명을 유지할지 여부 (보안에 문제가 없는 파일인 경우만 원본명 유지 가능)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String saveFile(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn) throws Exception;

	
	
}
