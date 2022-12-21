package com.hwfs.sc.cmn.service;

import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.AttachFileDTO;


 /**
 * 첨부파일을 관리하는 Service Interface
 * <pre>
 * - 첨부파일을 공통 테이블에 저장하고 디렉토리에 파일형태 또는 BLOB으로 저장한다. (현재 BLOB 미지원)
 * - 파일 암호화를 선택적으로 처리할 수 있다.
 * </pre>
 * @ClassName AttachFileService.java
 * @Description AttachFileService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014.12. 08.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014.12.08.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AttachFileService {
	
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
	public String save(DataSetMap listFile, String relPath, boolean encYn) throws Exception;

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
	public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn) throws Exception;

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
	public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn) throws Exception;

	/**
	 * 첨부파일 정보를 조회한다.
	 * 
	 * @param strRefSeq
	 *            - 첨부파일 참조일련번호
	 * @param lngAtchSeq
	 *            - 첨부일련번호
	 * @return 첨부파일정보 VO
	 * @exception Exception
	 */
	public AttachFileDTO selectFileInfo(String strRefSeq, long lngAtchSeq) throws Exception;

	/**
	 * 첨부파일 목록을 조회한다.
	 * <pre>
	 * 첨부파일 참조일련번호에 관련된 모든 첨부파일 정보를 조회한다. 
	 * </pre>
	 *
	 * @param strSeqRel 첨부파일 참조일련번호
	 * @return 첨부파일 목록 List<Map>
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> selectList(String strSeqRel) throws Exception;

	/**
	 * 첨부파일을 삭제한다.
	 * <pre>
	 * - 첨부파일 테이블과 파일저장소의 파일을 함께 삭제한다.
     * - 파일 저장소는 global.filerepository.path가 된다.
	 * </pre>
	 * 
	 * @param lngSeqRel 첨부파일 참조일련번호
	 * @return 처리건수
	 * @throws Exception
	 */
	public int delete (String strSeqRel) throws Exception;

	/**
	 * 첨부파일을 삭제한다.
	 * <pre>
	 * - 첨부파일 테이블과 파일저장소의 파일을 함께 삭제한다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다. 
	 * </pre>
	 * 
	 * @param lngSeqRel 첨부파일 참조일련번호
     * @param webRepoYn 파일저장소가 webapp 아래인지 여부(true이면 global.imagerepository.path 아래가 된다.)
	 * @return 처리건수
	 * @throws Exception
	 */
	public int delete (String strSeqRel, boolean webRepoYn) throws Exception;

}
