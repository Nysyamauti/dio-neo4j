# DIO challenge - Creating a Music Recommendation Algorithm with Graphs

## Challenge Context
You have been hired to develop a music recommendation system that uses graphs to identify listening patterns and suggest new tracks to users. The system must be able to:
* Represent **users**, **songs**, **composers**, **genres** as graph nodes.
* Represent interactions (like **listening**, **liking**, **following**) as relationships with properties.
* Use **Cypher queries** to generate personalized recommendations based on graph connections.

## Graph Data Model & Setup

### Nodes & Relationships
* **Nodes:** `:User`, `:Song`, `:Composer`, `:Genre`
* **Relationships:** `[:LISTENED {plays}]`, `[:LIKED]`, `[:FOLLOWS]`, `[:COMPOSED_BY {date}]`, `[:BELONGS_TO]`

### How to Run
1. Open a free instance on **Neo4j AuraDB** (Query tab).
2. Run [`01-seed.cypher`](./queries/01-seed.cypher) to populate the database using `MERGE` statements.
3. Execute the analytical queries from [`02-recommendations.cypher`](./queries/02-recommendations.cypher).

* Neo4j/5.27-aura

## Difficults
* Formalidades de Structure
* Funcionalidade e regras do MERGE

## Business ...
1. Recomendação por Compositor Seguido (Artist-Based Recommendation):
	• Pergunta: Quais músicas foram compostas por artistas que o usuário f1 segue, mas que ele ainda não ouviu? (Vai recomendar Alone).

MATCH (u:User {name: 'f1'})-[:FOLLOWS]->(c:Composer)<-[:COMPOSED_BY]-(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN c.name AS Composer, rec.name AS RecommendedSong

2. Recomendação por Afinidade de Gênero (Content-Based Filtering):
	• Pergunta: Com base no gênero das músicas que o usuário f1 curtiu (LIKED), quais outras músicas do mesmo gênero ele ainda não conhece? (Vai recomendar Alone e Happier).

MATCH (u:User {name: 'f1'})-[:LIKED]->(s:Song)-[:BELONGS_TO]->(g:Genre)<-[:BELONGS_TO]-(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN DISTINCT rec.name AS MusicNotListening

3. Filtragem Colaborativa (Collaborative Filtering):
	• Pergunta: Quais músicas foram curtidas por outros usuários que também ouviram as mesmas faixas que f1, excluindo o que f1 já ouviu? (Vai cruzar f1 com f2 através de Faded e recomendar Lose Yourself e Alone).

MATCH (u:User {name: 'f1'})-[:LISTENED]->(s:Song)<-[:LISTENED]-(other:User)-[:LIKED]->(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN DISTINCT other.name AS SimilarUser, rec.name AS RecommendedSong

4. Ranking de Popularidade (Aggregation & Ordering):
	• Pergunta: Quais são as músicas mais ouvidas da plataforma somando a propriedade plays de todos os usuários? (Vai treinar SUM(), ORDER BY e LIMIT, essenciais para a certificação).

MATCH (:User)-[r:LISTENED]->(s:Song)
RETURN s.name AS Song, sum(r.plays) AS TotalPlays
ORDER BY TotalPlays DESC
LIMIT 3