# Example B: Movie Co-actors Network

Build a co-actor network that shows which actors have worked together and how frequently!

## Business Scenario

You're a film industry analyst studying actor collaborations. You have movie and cast data from a streaming platform. Your goal is to:
1. Identify which actors have worked together
2. Count how many movies they've shared
3. Build a network dataset for visualization or further analysis

This demonstrates a common pattern: joining multiple datasets and creating relationship networks from transactional data.

## What You'll Build

A pipeline that:
- **Loads** two CSV files (`movies.csv` and `cast.csv`)
- **Joins** movie and cast data together
- **Creates** actor pairs from movies they've appeared in together
- **Counts** how many times each pair has co-starred
- **Outputs** a co-actor network to a Parquet file

## The Data

**movies.csv** contains:
- `movie_id` - Unique movie identifier
- `movie_title` - Name of the movie
- `release_year` - Year released
- `genre` - Movie genre

**cast.csv** contains:
- `movie_id` - Movie identifier (links to movies.csv)
- `actor_name` - Name of the actor
- `role_type` - Lead or Supporting

**Sample data**: 10 movies with 6 actors across various collaborations

## Getting Started

### Prerequisites

Make sure you've completed the [Getting Started Guide](../../getting_started.md):
- ✅ Cloned this repository
- ✅ Installed Osiris in a virtual environment
- ✅ Configured MCP with Claude Desktop or Claude Code
- ✅ Verified Osiris is working (`osiris --version`)
- ✅ Docker installed and running (for database setup)

### Step 1: Start the Database

This example uses a Postgres database to demonstrate real-world data source connectivity.

**Start the database:**
```bash
cd examples/B-movies
docker-compose up -d
```

**Verify it's running:**
```bash
docker ps | grep osiris-movies-db
```

**Check the data:**
```bash
docker exec -it osiris-movies-db psql -U osiris -d movies -c "SELECT COUNT(*) FROM movies;"
docker exec -it osiris-movies-db psql -U osiris -d movies -c "SELECT COUNT(*) FROM cast;"
```

You should see 10 movies and 27 cast records.

**Connection details:**
- Host: `localhost`
- Port: `5432`
- Database: `movies`
- User: `osiris`
- Password: `osiris_pass`
- Tables: `movies`, `cast`

**Alternative: Use CSV files**

If you prefer to work with CSV files instead of Postgres, you can use the files in `data/` directory and modify the prompts accordingly.

### Step 2: Use Claude to Build the Pipeline

This is the AI-native approach - let Claude work with Osiris to build your pipeline!

**Open Claude:**

**Claude Desktop:**
- Make sure Osiris MCP server is connected (check connectors panel)

**Claude Code:**
- Open this workspace in VS Code
- Verify Osiris is connected: run `/mcp` and look for "osiris"

**Use the Starter Prompt:**

Copy and paste this prompt into Claude:

```
I want to build a co-actor network analysis pipeline using the Postgres database.

Connection details:
- Host: localhost
- Port: 5432
- Database: movies
- User: osiris
- Password: osiris_pass

Please:
1. Connect to the Postgres database and load the 'movies' and 'cast' tables
2. Join the datasets to get movie-actor relationships
3. Create a co-actor matrix showing how many times each pair of actors appeared together
4. Calculate co-actor frequency (number of shared movies)
5. Save the results to outputs/coactor_network.parquet

The output should have columns: actor1, actor2, movies_together

Before writing the pipeline, please:
- Ask me any clarifying questions
- Explain what steps you'll take
- Show me the pipeline structure

Let me review and approve before you create it.
```

**Review and Run:**

Claude will:
1. Ask clarifying questions (answer based on your preferences)
2. Propose a pipeline structure
3. Validate the pipeline using Osiris tools
4. Help you run it

You can ask Claude to:
- Explain any step in detail
- Modify the pipeline (e.g., filter by genre, include movie titles)
- Validate the output
- Debug any issues

## Expected Output

After running the pipeline, you should see a co-actor network with actor pairs and their collaboration frequency.

**Sample results**:
| actor1         | actor2         | movies_together |
|----------------|----------------|-----------------|
| Alice Johnson  | Bob Smith      | 3               |
| Alice Johnson  | Carol White    | 2               |
| Bob Smith      | Carol White    | 2               |
| ...            | ...            | ...             |

## Troubleshooting

**Pipeline fails to connect to database:**
- Check that Docker is running: `docker ps`
- Verify the container is running: `docker ps | grep osiris-movies-db`
- Check container logs: `docker logs osiris-movies-db`
- Ensure port 5432 is not in use by another service

**Connection refused errors:**
- Wait a few seconds for Postgres to fully start
- Check the healthcheck: `docker inspect osiris-movies-db | grep Health`
- Try restarting: `docker-compose restart`

**Join issues:**
- Verify movie_id columns exist in both datasets
- Check for type mismatches between join keys
- Review the logs: `osiris logs`

**Output not generated:**
- Check the pipeline completed successfully
- Look in `outputs/` directory (create if missing)
- Review execution logs for errors

## Cleanup

When you're done with this example, stop the database:

```bash
cd examples/B-movies
docker-compose down
```

To completely remove the database and its data:

```bash
docker-compose down -v
```

## Next Steps

Once you've completed this example:

1. **Experiment**: Modify the pipeline to:
   - Filter by genre (e.g., only Action movies)
   - Include movie titles in the output
   - Calculate average release year for each actor pair
2. **Try Example C**: [Logistics Bronze to Gold](../C-logistics/) - multi-layer transformations

---

**Ready to build?** Use the starter prompt above with Claude!
