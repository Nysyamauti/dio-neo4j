// BUSINESS QUESTIONS & RECOMMENDATION QUERIES

// 1. Artist-Based Recommendation
// Find songs composed by artists that user 'f1' follows, excluding already listened tracks.
MATCH (u:User {name: 'f1'})-[:FOLLOWS]->(c:Composer)<-[:COMPOSED_BY]-(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN c.name AS Composer, rec.name AS RecommendedSong;

// 2. Genre-Based Recommendation (Content-Based Filtering)
// Find other songs in the same genre as tracks liked by 'f1' that they haven't heard yet.
MATCH (u:User {name: 'f1'})-[:LIKED]->(s:Song)-[:BELONGS_TO]->(g:Genre)<-[:BELONGS_TO]-(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN DISTINCT g.name AS Genre, rec.name AS RecommendedSong;

// 3. Collaborative Filtering
// Find songs liked by other users who listened to the same tracks as 'f1'.
MATCH (u:User {name: 'f1'})-[:LISTENED]->(s:Song)<-[:LISTENED]-(other:User)-[:LIKED]->(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN DISTINCT other.name AS SimilarUser, rec.name AS RecommendedSong;

// 4. Platform Popularity Ranking
// Rank the top 3 most played songs across all users using implicit aggregation.
MATCH (:User)-[r:LISTENED]->(s:Song)
RETURN s.name AS Song, SUM(r.plays) AS TotalPlays
ORDER BY TotalPlays DESC
LIMIT 3;