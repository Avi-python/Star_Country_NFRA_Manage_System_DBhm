use nfra_forest_management;

-- rpq.id AS request_process_qualification_id, pd.name AS process_department_name, pd.address AS process_department_address 

-- Question 1

-- 超過一個月且批准數 < 2
SELECT rpq.id AS request_process_qualification_id, COUNT(review.is_passed) AS passed_number, rpq.start_date AS request_date, pd.id AS process_department_id, pd.name AS process_department_name, pd.address AS process_department_address
FROM ((request_process_qualification AS rpq JOIN process_department AS pd ON rpq.process_department_id = pd.id) LEFT JOIN review ON (rpq.id = review.request_process_qualification_id and review.is_passed = 1))
WHERE DATEDIFF('2024-5-13', rpq.start_date) > 31 -- 
AND (SELECT COUNT(*) FROM request_process_qualification AS rpq2, review AS r2 where pd.id = rpq2.process_department_id and rpq2.id = r2.request_process_qualification_id and r2.is_passed = 1) < 2
GROUP BY rpq.id, pd.id

UNION

-- 不管任何時間批准數 > 2
SELECT rpq.id AS request_process_qualification_id, COUNT(review.is_passed) AS passed_number, rpq.start_date AS request_date, pd.id AS process_department_id, pd.name AS process_department_name, pd.address AS process_department_address
FROM ((request_process_qualification AS rpq JOIN process_department AS pd ON rpq.process_department_id = pd.id) LEFT JOIN review ON (rpq.id = review.request_process_qualification_id and review.is_passed = 1))
WHERE (SELECT COUNT(*) FROM request_process_qualification AS rpq2, review AS r2 where pd.id = rpq2.process_department_id and rpq2.id = r2.request_process_qualification_id and r2.is_passed = 1) >= 2
GROUP BY rpq.id, pd.id;

-- Question 2	

-- Q2-1
SELECT e.id, e.start_date, e.`description`, nfra.id, nfra.`name`  
FROM (emergency AS e JOIN nfra ON (e.nfra_id = nfra.id)) 
WHERE NOT EXISTS ( SELECT * FROM solving WHERE e.id = solving.emergency_id ) and e.is_finished = 0;

-- Q2-2
SELECT e2.id, e2.`description`, e2.nfra_id, n2.`name`
FROM ((emergency AS e 
JOIN nfra ON (e.nfra_id = nfra.id AND NOT EXISTS ( SELECT * FROM solving WHERE e.id = solving.emergency_id ) and e.is_finished = 0) 
) JOIN emergency AS e2 ON (e.`description` = e2.`description` and e.nfra_id != e2.nfra_id)), nfra AS n2 
WHERE e2.nfra_id = n2.id;

-- Q2-Final

SELECT 
  COUNT(*), 
  related_emergency.`description` AS emergency_description, 
  pd.id AS process_department_id, 
  pd.`name` AS process_department_name, 
  pd.address AS process_department_address 
FROM 
  solving 
  JOIN (
    SELECT 
      e2.id, 
      e2.`description`, 
      e2.nfra_id, 
      n2.`name` 
    FROM 
      (
        (
          emergency AS e 
          JOIN nfra ON (
            e.nfra_id = nfra.id 
            AND NOT EXISTS (
              SELECT 
                * 
              FROM 
                solving 
              WHERE 
                e.id = solving.emergency_id
            ) 
            and e.is_finished = 0
          )
        ) 
        JOIN emergency AS e2 ON (
          e.`description` = e2.`description` 
          and e.nfra_id != e2.nfra_id
        )
      ), 
      nfra AS n2 
    WHERE 
      e2.nfra_id = n2.id
  ) AS related_emergency ON solving.emergency_id = related_emergency.id, 
  process_department AS pd 
WHERE 
  pd.id = solving.process_department_id 
GROUP BY 
  pd.id, 
  related_emergency.`description`
ORDER BY
  related_emergency.`description`
;

-- Question 3 「正在處理」

SELECT 
  COUNT(*), 
  qualifi_pd.id AS process_department_id, 
  qualifi_pd.`name` AS process_department_name, 
  qualifi_pd.address AS process_department_address 
FROM 
  `event` 
  JOIN (
    SELECT 
      pd1.`name`, 
      pd1.id, 
      pd1.address 
    FROM 
      process_department as pd1 
    WHERE 
      EXISTS (
        SELECT 
          * 
        FROM 
          process_qualification AS pq 
        WHERE 
          pd1.id = pq.process_department_id
      ) 
      AND (
        pd1.`name` LIKE '%集團' 
        OR pd1.`name` LIKE '%聯盟'
      )
  ) AS qualifi_pd ON (
    `event`.process_department_id = qualifi_pd.id
  ) 
WHERE
  '2024-05-13' BETWEEN `event`.start_date AND `event`.end_date
GROUP BY 
  qualifi_pd.`name`, 
  qualifi_pd.id 
HAVING 
  COUNT(*) < 2;

