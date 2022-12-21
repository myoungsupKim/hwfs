package com.hwfs.guide.sample.service;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.guide.sample.dto.SampleSearchDTO;
import com.hwfs.guide.sample.dto.SampleDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * Sample Service Interface
 * @ClassName SampleService.java
 * @Description SampleService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 4.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 kksoo
 * @since 2014. 11. 4.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SampleService {

    /**
	 * 글 목록을 Page 단위로 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleListPage(SearchParameters searchParameters) throws Exception;

    /**
	 * 글 목록을 Page 단위로 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleListPage(SampleSearchDTO searchDTO) throws Exception;

    /**
	 * 글 목록을 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleList(SampleSearchDTO searchDTO) throws Exception;

    public RecordSet selectSampleList(Map<String, Object> searchMap) throws Exception;

    public List<Map> selectSampleListMap(SampleSearchDTO searchDTO) throws Exception;
    
    public List<Map> selectSampleListMap(Map<String, Object> searchMap) throws Exception;

    public List<SampleDTO> selectSampleListDTO(SampleSearchDTO searchDTO) throws Exception;

    /**
	 * 글 목록 건수를 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 건수
	 * @exception Exception
	 */
    public int selectSampleCount(SampleSearchDTO searchDTO) throws Exception;
    
    public int selectSampleCount(Map<String, Object> searchMap) throws Exception;

    /**
     * 데이터셋을 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - DataSet 전체를 Map형태로 데이터 전달
     * </pre>
     *
     * @param inDataset
     * @return 처리건수
     * @throws Exception
     */
	public int saveSample(Map <String, DataSetMap> inDataset) throws Exception;

    /**
     * 데이터셋을 rowType에 따라 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - DataSetMap형태로 통합 데이터셋 전달
     * - rowType 건별로 루프를 돌며 처리
     * </pre>
     *
     * @param dsMap
     * @return 처리건수
     * @throws Exception
     */
	public int saveSample(DataSetMap dsMap) throws Exception;

	/**
     * 데이터셋을 rowType에 따라 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - DataSetMap형태로 통합 데이터셋 전달
     * - rowType 그룹별로 처리 (배치 처리에 유용)
     * </pre>
     *
     * @param dsMap
     * @return 처리건수
     * @throws Exception
	 */
	public int saveSample2(DataSetMap dsMap) throws Exception;

    /**
      * Grid 데이터를 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - Insert/Update/Delete 별로 분리하여 데이터 전달
     * - DTO형태로 데이터 전달
     * </pre>
     *
     * @param listIns Insert List
     * @param listUpd Update List
     * @param listDel Delete List
     * @return 처리건수
     * @throws Exception
     */
    public int saveSample (List<SampleDTO> listIns, List<SampleDTO> listUpd, List<SampleDTO> listDel) throws Exception;

    /**
     * Grid 데이터를 Insert/Update/Delete 처리하는 샘플
    * <pre>
    * - Insert/Update/Delete 별로 분리하여 데이터 전달
    * - Map형태로 데이터 전달
    * </pre>
    *
    * @param listIns Insert List
    * @param listUpd Update List
    * @param listDel Delete List
    * @return 처리건수
    * @throws Exception
    */
   public int saveSampleToMap (List<Map<String, Object>> listIns, List<Map<String, Object>> listUpd, List<Map<String, Object>> listDel) throws Exception;

   /**
    * XPLATFORM DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
    * <pre>
    * - 데이터와 첨부파일을 함께 처리한다.
    * </pre>
    * 
    * @param list 데이터
    * @parma listFile 첨부파일 정보
    * @param loginDTO 로그인 DTO
    * @return 첨부참조일련번호
    * @throws Exception
    */
   public String saveSampleAttachFile(DataSetMap list, DataSetMap listFile, LoginDTO loginDTO) throws Exception;
}
