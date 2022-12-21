package com.hwfs.guide.sample.service;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.SampleDAO;
import com.hwfs.guide.sample.dto.SampleDTO;
import com.hwfs.guide.sample.dto.SampleSearchDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

/**
 * Sample Service Implementation
 * @ClassName SampleServiceImpl.java
 * @Description SampleServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 4.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 11. 4.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/sampleService")
public class SampleServiceImpl extends DefaultServiceImpl implements SampleService {

	//@Autowired @Qualifier("/guide/sample/sampleDAO")
	@Resource(name="/guide/sample/sampleDAO")
	private SampleDAO sampleDAO;
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	
    /**
	 * 글 목록을 Page 단위로 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleListPage(SearchParameters searchParameters) throws Exception {
    	return sampleDAO.selectSampleListPage(searchParameters);
    }

    /**
	 * 글 목록을 Page 단위로 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleListPage(SampleSearchDTO searchDTO) throws Exception {
    	return sampleDAO.selectSampleListPage(searchDTO);
    }

    /**
	 * 글 목록을 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleList(SampleSearchDTO searchDTO) throws Exception {
    	return sampleDAO.selectSampleList(searchDTO);
    }

    /**
	 * 글 목록을 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    public RecordSet selectSampleList(Map<String, Object> searchMap) throws Exception {
    	return sampleDAO.selectSampleList(searchMap);
    }

    /**
	 * 글 목록을 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 글 목록
	 * @exception Exception
	 */
    @SuppressWarnings("rawtypes")
	public List<Map> selectSampleListMap(SampleSearchDTO searchDTO) throws Exception {
    	return sampleDAO.selectSampleListMap(searchDTO);
    }

	public List<Map> selectSampleListMap(Map<String, Object> searchMap) throws Exception {
    	return sampleDAO.selectSampleListMap(searchMap);
    }

    public List<SampleDTO> selectSampleListDTO(SampleSearchDTO searchDTO) throws Exception {
    	return sampleDAO.selectSampleListDTO(searchDTO);
    }

    /**
	 * 글 목록 건수를 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 건수
	 * @exception Exception
	 */
    public int selectSampleCount(SampleSearchDTO searchDTO) throws Exception {
    	return sampleDAO.selectSampleCount(searchDTO);
    }

    public int selectSampleCount(Map<String, Object> searchMap) throws Exception {
    	return sampleDAO.selectSampleCount(searchMap);
    }

    /**
     * 데이터셋을 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - DataSet 전체를 Map형태로 데이터 전달
     * - 전달할 데이터셋이 많은 경우 유용하지만 Controller 단에서 DataSetMap 단위로 전달하는 것이 좋다.
     * </pre>
     *
     * @param inDataset
     * @return 처리건수
     * @throws Exception
     */
	public int saveSample(Map <String, DataSetMap> inDataset) throws Exception {
		DataSetMap list = (DataSetMap) inDataset.get("ds_input");
		return saveSample (list);
	}

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
	@SuppressWarnings("unchecked")
	public int saveSample(DataSetMap dsMap) throws Exception {
		int intCnt=0;
		
		//rowType에 따라 처리
		for (int i = 0; i < dsMap.size(); i++) {
			Map<String, Object> map = dsMap.get(i);
			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				intCnt += sampleDAO.insertSample(map);
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += sampleDAO.updateSample(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += sampleDAO.deleteSample(map);
			}
		}
		return intCnt;
	}

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
	public int saveSample2(DataSetMap dsMap) throws Exception {
    	//rowType 그룹별로 처리
    	int delCount = sampleDAO.deleteSampleToMap (dsMap.getDelRowMaps());
    	int insCount = sampleDAO.insertSampleToMap (dsMap.getInsRowMaps());
    	int updCount = sampleDAO.updateSampleToMap (dsMap.getUpdRowMaps());

//    	//Batch처리
//    	int delCount = sampleDAO.batchDeleteSampleToMap(dsMap.getDelRowMaps());
//    	int insCount = sampleDAO.batchInsertSampleToMap(dsMap.getInsRowMaps());
//    	int updCount = sampleDAO.batchUpdateSampleToMap(dsMap.getUpdRowMaps());

    	return delCount + insCount + updCount; 
	}

    /**
     * 데이터셋을 Insert/Update/Delete 처리하는 샘플
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
    public int saveSample (List<SampleDTO> listIns, List<SampleDTO> listUpd, List<SampleDTO> listDel) throws Exception {
    	//건건 처리
    	int delCount = sampleDAO.deleteSample (listDel);
    	int insCount = sampleDAO.insertSample (listIns);
    	int updCount = sampleDAO.updateSample (listUpd);

//    	//Batch처리
//    	int delCount = sampleDAO.batchDeleteSample(listDel);
//    	int insCount = sampleDAO.batchInsertSample (listIns);
//    	int updCount = sampleDAO.batchUpdateSample (listUpd);

    	//call procedure test용
    	Map<String, Object> outMap =  callProcedureSample ();
    	
    	return delCount + insCount + updCount; 
    }

    /**
     * 데이터셋을  Insert/Update/Delete 처리하는 샘플
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
    public int saveSampleToMap (List<Map<String, Object>> listIns, List<Map<String, Object>> listUpd, List<Map<String, Object>> listDel) throws Exception {
    	//건건 처리
    	int delCount = sampleDAO.deleteSampleToMap (listDel);
    	int insCount = sampleDAO.insertSampleToMap (listIns);
    	int updCount = sampleDAO.updateSampleToMap (listUpd);

//    	//Batch처리 : DTO와 동일 방식
//    	int delCount = sampleDAO.batchDeleteSampleToMap(listDel);
//    	int insCount = sampleDAO.batchInsertSampleToMap(listIns);
//    	int updCount = sampleDAO.batchUpdateSampleToMap(listUpd);

    	//Exception 테스트용
    	//if (true)
    	//	throw super.processException("message.test03", new Object[]{"123","456"});
    	
    	return delCount + insCount + updCount; 
    }

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
	@SuppressWarnings({ "unchecked", "unused" })
	public String saveSampleAttachFile(DataSetMap list, DataSetMap listFile, LoginDTO loginDTO) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호
		
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("sample.path"), false);
		
		int intCnt=0;
		//데이터 저장 처리
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
				map.put("refSeq", strRefSeq);

			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				intCnt += sampleDAO.insertSample(map);
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += sampleDAO.updateSample(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += sampleDAO.deleteSample(map);
			}else if (!strRefSeq.equals("")) {
				//(주의)나머지 rowType인 경우 첨부참조일련번호가 새로 채번된 경우 Update하도록 함 
				intCnt += sampleDAO.updateSample(map);
			}
		}
		
		return strRefSeq;
	}

	/**
	 * Stored Procedure 호출 Sample
	 * 
	 * @return 처리결과Map
	 * @throws Exception
	 */
	private Map<String, Object> callProcedureSample () throws Exception {
		Map<String, Object> inParam = new HashMap<String, Object>();
		inParam.put("pi_guid2", "test"); //오류 테스트
		return sampleDAO.callProcedureSample(inParam);
	}
}
