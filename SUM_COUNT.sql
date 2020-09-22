#6. For each continent show the continent and number of countries.

select continent, count(*) from world
group by continent 

# 7. For each continent show the continent and number of countries with populations of at least 10 million.

select continent,count(*) from world
where population >= 10000000
group by continent

# 8. List the continents that have a total population of at least 100 million.

select continent from world
group by continent
having sum(population) >=  100000000
