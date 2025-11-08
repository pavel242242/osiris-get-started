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

### Using Claude (Recommended)

This is the AI-native approach - let Claude work with Osiris to build your pipeline!

#### Step 1: Open Claude

**Claude Desktop:**
- Make sure Osiris MCP server is connected (check connectors panel)

**Claude Code:**
- Open this workspace in VS Code
- Verify Osiris is connected: run `/mcp` and look for "osiris"

#### Step 2: Use the Starter Prompt

Copy and paste this prompt into Claude:

```
I want to build a co-actor network analysis pipeline using the data in examples/B-movies/data/.

Please:
1. Load movies.csv and cast.csv from examples/B-movies/data/
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

#### Step 3: Review and Run

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

**Pipeline fails to load CSV files:**
- Check that you're running from the repository root
- Verify `OSIRIS_HOME` is set correctly
- Confirm the data files exist: `ls examples/B-movies/data/`

**Join issues:**
- Verify movie_id columns exist in both datasets
- Check for type mismatches between join keys
- Review the logs: `osiris logs`

**Output not generated:**
- Check the pipeline completed successfully
- Look in `outputs/` directory (create if missing)
- Review execution logs for errors

## Next Steps

Once you've completed this example:

1. **Experiment**: Modify the pipeline to:
   - Filter by genre (e.g., only Action movies)
   - Include movie titles in the output
   - Calculate average release year for each actor pair
2. **Try Example C**: [Logistics Bronze to Gold](../C-logistics/) - multi-layer transformations

---

**Ready to build?** Use the starter prompt above with Claude!
