package com.hwfs.guide.sample.dao;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;
import hone.core.util.record.RecordUtils;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.SqlInOutParameter;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.guide.sample.dto.SampleSearchDTO;
import com.hwfs.guide.sample.dto.SampleDTO;

/**
 * Sample Dao Implementation
 * @ClassName SampleDaoImpl.java
 * @Description SampleDaoImpl Class 
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
@Repository("/guide/sample/sampleDAO")
public class SampleDAO extends DefaultDAO {

    /**
	 * 글 목록을 Page 단위로 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록
	 * @exception Exception
	 */
	public RecordSet selectSampleListPage(SearchParameters searchParameters) throws Exception {
		//페이지 파라미터 바인딩
		searchParameters.set("firstIndex", Integer.valueOf( ( searchParameters.getCurrentPage() - 1 ) * searchParameters.getVolumePerPage() ) );
		searchParameters.set("recordCountPerPage", searchParameters.getVolumePerPage() );

		//sql name = hqml document name.statement name
		String sql = getSql("guide.sample.sampleDAO.selectSampleListPage", searchParameters);
		
		return queryForRecordSet(sql, searchParameters );
    }

	//다양한 형태의 Parameter Binding 테스트
	public RecordSet selectSampleListPage(SampleSearchDTO searchDTO) throws Exception {
		//1) bean으로 parameter binding
		BeanPropertySqlParameterSource beanSqlParams  = new BeanPropertySqlParameterSource(searchDTO);
		//sql name = hqml document name.statement name
		String sql = getSql("guide.sample.sampleDAO.selectSampleListPage", beanSqlParams);
		
		return queryForRecordSet(sql, beanSqlParams );
		
//		//2) Record로 parameter binding
//		@SuppressWarnings({ "rawtypes", "unchecked" })
//		Record record = new RecordWrapper(searchDTO);
//		
//		//sql name = hqml document name.statement name
//		String sql = getSql("guide.sample.sampleDAO.selectSampleListPage", record);
//		
//		return queryForRecordSet(sql, record);
		
		//3)Map으로 parameter binding
//		HashMap<String, Object> mapParams = new HashMap<String, Object>();
//		mapParams.put("firstIndex", searchDTO.getFirstIndex());
//		mapParams.put("recordCountPerPage", searchDTO.getRecordCountPerPage());
//		mapParams.put("id", "1111");
//		
//		MapSqlParameterSource sqlParams = new MapSqlParameterSource();
//		sqlParams.addValues(mapParams);
//		
//		//sql name = hqml document name.statement name
//		String sql = getSql("guide.sample.sampleDAO.selectSampleListPage", sqlParams);
//		
//		return queryForRecordSet(sql, sqlParams);
	}

    /**
	 * 글 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록 RecordSet
	 * @exception Exception
	 */
	public RecordSet selectSampleList(Map<String, Object> searchMap) throws Exception {
		return super.queryForRecordSet ("guide.sample.sampleDAO.selectSampleList", searchMap);
	}

    /**
	 * 글 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록 RecordSet
	 * @exception Exception
	 */
	public RecordSet selectSampleList(SampleSearchDTO searchDTO) throws Exception {
		return queryForRecordSet("guide.sample.sampleDAO.selectSampleList", searchDTO);
	}

	@SuppressWarnings("rawtypes")
	public List<Map> selectSampleListMap(SampleSearchDTO searchDTO) throws Exception {
		return queryForList ("guide.sample.sampleDAO.selectSampleList", searchDTO);
	}

	@SuppressWarnings("rawtypes")
	public List<Map> selectSampleListMap(Map<String, Object> searchMap) throws Exception {
		return queryForList ("guide.sample.sampleDAO.selectSampleList", searchMap);
	}

	@SuppressWarnings("unchecked")
	public List<SampleDTO> selectSampleListDTO(SampleSearchDTO searchDTO) throws Exception {
		return (List<SampleDTO>)queryForList ("guide.sample.sampleDAO.selectSampleList", searchDTO, SampleDTO.class);
	}

	/**
	 * 글 목록 건수를 조회한다.
	 * @param searchDTO - 조회할 정보가 담긴 DTO
	 * @return 건수
	 * @exception Exception
	 */
	public int selectSampleCount(SampleSearchDTO searchDTO) throws Exception {
		//1)
		return queryForInt ("guide.sample.sampleDAO.selectSampleCount", searchDTO);

		//2)
//		Map<String, Object> searchMap = new HashMap<String, Object>();
//		searchMap.put("id", "SAMPLE-00000");
//		return queryForInt ("guide.sample.sampleDAO.selectSampleCount", searchMap);
		
		//3)
//		Record record = new MapRecord();
//		record.put("id", "SAMPLE-00000");
//		Integer cnt = (Integer)queryForObject ("guide.sample.sampleDAO.selectSampleCount", record, Integer.class);
//		return cnt.intValue();

		//4)
//		Integer cnt = (Integer)queryForObject ("guide.sample.sampleDAO.selectSampleCount", searchDTO, Integer.class);;
//		return cnt.intValue();
		
	}

	/**
	 * 글 목록 건수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectSampleCount(Map<String, Object> searchMap) throws Exception {
		return queryForInt ("guide.sample.sampleDAO.selectSampleCount", searchMap);
	}

	/**
	 * List 데이터를 insert한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int insertSample (List<SampleDTO> list) throws Exception {
		int count=0;
		for (SampleDTO sampleDTO:list) {
			count += super.update("guide.sample.sampleDAO.insertSampleDynamic",sampleDTO);
		}
		return count;
	}

	/**
	 * 
	 * 데이터를 insert한다.
	 *
	 * @param map
	 * @return 건수
	 * @throws Exception
	 */
    public int insertSample(Map<String, Object> map) throws Exception {
    	return super.update("guide.sample.sampleDAO.insertSampleDynamic", map);
    }

	/**
	 * List 데이터를 update한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int updateSample (List<SampleDTO> list) throws Exception {
		int count=0;
		for (SampleDTO sampleDTO:list) {
			count += super.update("guide.sample.sampleDAO.updateSampleDynamic",sampleDTO);
		}
		return count;
	}

	/**
	 * List 데이터를 update한다.
	 *
	 * @param map
	 * @return 건수
	 * @throws Exception
	 */
    public int updateSample(Map <String,Object> map) throws Exception {
        return super.update("guide.sample.sampleDAO.updateSampleDynamic", map);
    }

	/**
	 * List 데이터를 delete한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int deleteSample (List<SampleDTO> list) throws Exception {
		int count=0;
		for (SampleDTO sampleDTO:list) {
			count += super.update("guide.sample.sampleDAO.deleteSample",sampleDTO);
		}
		return count;
	}

	/**
	 * 데이터를 delete한다.
	 *
	 * @param map
	 * @return 건수
	 * @throws Exception
	 */
    public int deleteSample(Map<String,Object> map) throws Exception {
        return super.update("guide.sample.sampleDAO.deleteSample", map);
    }

	/**
	 * Grid 데이터를 Batch Insert한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int batchInsertSample (List<SampleDTO> list) throws Exception {
		if (list.size() <= 0) return 0;
		return super.batchUpdate2 ("guide.sample.sampleDAO.insertSample", list);
	}

	/**
	 * Grid 데이터를 Batch Update한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int batchUpdateSample (List<SampleDTO> list) throws Exception {
		if (list.size() <= 0) return 0;
		return super.batchUpdate2 ("guide.sample.sampleDAO.updateSample", list);
	}

	/**
	 * Grid 데이터를 Batch Delete한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int batchDeleteSample (List<SampleDTO> list) throws Exception {
		if (list.size() <= 0) return 0;
		return super.batchUpdate2 ("guide.sample.sampleDAO.deleteSample", list);
	}

	/**
	 * Grid 데이터를 insert한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int insertSampleToMap (List<Map<String, Object>> list) throws Exception {
		int count=0;
		for (Map<String, Object> map:list) {
			count += super.update("guide.sample.sampleDAO.insertSampleDynamic", map);
		}
		return count;
	}

	/**
	 * Grid 데이터를 update한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int updateSampleToMap (List<Map<String, Object>> list) throws Exception {
		int count=0;
		for (Map<String, Object> map:list) {
			count += super.update("guide.sample.sampleDAO.updateSampleDynamic", map);
		}
		return count;
	}

	/**
	 * Grid 데이터를 delete한다.
	 * @param list
	 * @return 건수
	 * @exception Exception
	 */
	public int deleteSampleToMap (List<Map<String, Object>> list) throws Exception {
		int count=0;
		for (Map<String, Object> map:list) {
			count += super.update("guide.sample.sampleDAO.deleteSample", map);
		}
		return count;
	}

	/**
	 * Grid 데이터를 Batch Insert한다.
	 * @param listIns
	 * @return 건수
	 * @exception Exception
	 */
	public int batchInsertSampleToMap (List<Map<String, Object>> listIns) throws Exception {
		if (listIns.size() <= 0) return 0;
		return super.batchUpdate2 ("guide.sample.sampleDAO.insertSample", listIns);
	}

	/**
	 * Grid 데이터를 Batch Update한다.
	 * @param listUpd
	 * @return 건수
	 * @exception Exception
	 */
	public int batchUpdateSampleToMap (List<Map<String, Object>> listUpd) throws Exception {
		if (listUpd.size() <= 0) return 0;
		return super.batchUpdate2 ("guide.sample.sampleDAO.updateSample", listUpd);
	}

	/**
	 * Grid 데이터를 Batch Delete한다.
	 * @param listDel
	 * @return 건수
	 * @exception Exception
	 */
	public int batchDeleteSampleToMap (List<Map<String, Object>> listDel) throws Exception {
		if (listDel.size() <= 0) return 0;
		return super.batchUpdate2 ("guide.sample.sampleDAO.deleteSample", listDel);
	}

	/**
	 * call Procedure Sample
	 * 
	 * @param inParam IN Parameter
	 * @return 결과 Map
	 */
	public Map<String, Object> callProcedureSample (Map<String, Object> inParam) throws Exception {
		// IN/OUT Parameter 설정
//		SqlParameter[] sqlParameter = new SqlParameter[] {
//				new SqlParameter("p_loc", Types.INTEGER),
//                new SqlParameter("p_yyyymm", Types.VARCHAR),
//                new SqlOutParameter("p_msg", Types.VARCHAR),
//                new SqlOutParameter("p_seq", Types.INTEGER),
//                new SqlInOutParameter("p_seq2", Types.INTEGER)
//				};

		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("pi_guid", Types.VARCHAR),
            new SqlOutParameter("po_val", Types.INTEGER),
            new SqlOutParameter("po_data", Types.VARCHAR)
		};

		String procedureName = "PRO_GUIDE_SAMPLE";
		
		// procedure 호출
		return callProcedure (procedureName, sqlParameter, inParam);
	}
}
