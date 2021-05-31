-- 1.
SELECT MONTHNAME(charged_datetime) AS 'month', SUM(billing.amount) AS total_revenue
    FROM billing 
    WHERE charged_datetime >= '2012/03/01' AND charged_datetime < '2012/03/31';

-- 2.
SELECT billing.client_id, SUM(billing.amount) AS total_revenue
    FROM billing 
    WHERE client_id = '2';

-- 3. 
SELECT domain_name AS website, sites.client_id
    FROM sites
    WHERE client_id = '10';

-- 4.
SELECT client_id, COUNT(domain_name) AS number_of_websites, MONTHNAME(created_datetime) AS 'month', YEAR(created_datetime) AS 'year'
    FROM sites
    WHERE client_id = '1'
    GROUP BY MONTH(sites.created_datetime)
    ORDER BY sites.created_datetime DESC;

-- 5. 
SELECT domain_name as website, date_format(registered_datetime,"%M %d %Y") AS date_generated, count(leads.leads_id) AS number_of_leads
    FROM sites
    LEFT JOIN leads ON sites.site_id = leads.site_id
    WHERE registered_datetime >= '2011/01/01' AND registered_datetime < '2011/02/16'
    GROUP BY sites.domain_name;

-- 6.
SELECT CONCAT(clients.first_name," ", clients.last_name) AS client_name , count(leads.leads_id)
    FROM clients
    LEFT JOIN sites ON clients.client_id = sites.client_id
    LEFT JOIN leads ON sites.site_id = leads.site_id
    WHERE registered_datetime >= '2011/01/01' AND registered_datetime < '2011/12/31'
    GROUP BY clients.client_id
    ORDER BY COUNT(leads.leads_id) DESC;

-- 7. 
 SELECT CONCAT(clients.first_name," ", clients.last_name) AS client_name, count(leads_id) AS number_of_leads, date_format(registered_datetime,"%M") AS month
    FROM clients
    LEFT JOIN sites ON clients.client_id = sites.client_id
    LEFT JOIN leads ON sites.site_id = leads.site_id
    WHERE registered_datetime >= '2011/01/01' AND registered_datetime < '2011/06/31'
    GROUP BY registered_datetime;


-- 8. 
SELECT CONCAT(clients.first_name," ", clients.last_name) AS client_name, domain_name AS website, count(leads_id) AS number_of_leads,  date_format(registered_datetime,"%M %d %Y") AS date_generated
    FROM sites
    LEFT JOIN leads ON sites.site_id = leads.site_id
    LEFT JOIN clients ON clients.client_id = sites.client_id
    WHERE registered_datetime >= '2011/01/01' AND registered_datetime < '2011/012/31'
    GROUP BY sites.domain_name
    ORDER BY clients.client_id, COUNT(leads.leads_id) DESC;

   -- // PART 2 \\

    SELECT CONCAT(clients.first_name," ", clients.last_name) AS client_name, domain_name AS website, count(leads_id) AS number_of_leads,  date_format(registered_datetime,"%M %d %Y") AS date_generated
    FROM sites
    LEFT JOIN leads ON sites.site_id = leads.site_id
    LEFT JOIN clients ON clients.client_id = sites.client_id
    GROUP BY sites.domain_name
    ORDER BY clients.client_id, COUNT(leads.leads_id) DESC;
-- 9.  
SELECT CONCAT(clients.first_name," ", clients.last_name) AS client_name, sum(billing.amount) AS total_revenue, date_format(charged_datetime,"%M") AS month, date_format(charged_datetime,"%Y") AS year_charge
    FROM billing
    LEFT JOIN clients ON billing.client_id = clients.client_id
    GROUP BY billing.charged_datetime
    ORDER BY clients.client_id, charged_datetime ASC;

-- 10. 
SELECT CONCAT(clients.first_name," ", clients.last_name) AS client_name, GROUP_CONCAT(" ", domain_name) AS sites
    FROM sites
    LEFT JOIN clients ON clients.client_id = sites.client_id
    GROUP BY clients.client_id;