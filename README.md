# MMD Agents — Free

> Claude agents for product design and development teams.
> Built by [Multi-Modal Design](https://multimodaldesign.com).

---

## What is this?

When you work with Claude, you can give it a specific role to play — a structured
job description that makes it behave like a specialist rather than a generalist.
These are those roles, called **agents**.

This free pack gives you the two most useful starting points: one for scoping what
you're building, and one for keeping a record of the decisions you make along the way.

---

## What's included

### `/brief` — Feature scoping agent

Turns a rough idea into a clear, structured build plan through a short conversation.

Instead of dumping requirements at Claude and hoping for the best, `/brief` walks you
through a focused interview: what you're building, who it's for, what screens are
involved, and what success looks like. At the end you get a clean brief that any
designer or developer — human or AI — can work from.

**Good for:** kicking off any new feature, screen, or product decision.

---

### `decision-log` — Decision capture skill

Automatically records important decisions as structured `DEC-NNN` entries during
any Claude session.

Instead of key decisions disappearing into a chat thread, this skill prompts Claude
to capture them with context — what was decided, why, and what the alternatives were.
Over time these build into an evidence trail for your product.

**Good for:** any design, strategy, or planning work where the *why* matters later.

---

## Installing

You need a Mac or Linux machine with Terminal. No other setup required.

**Step 1** — Open Terminal and navigate to your project folder:
```bash
cd "/path/to/your/project"
```

**Step 2** — Run the installer:
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jason-davey/mmd-agents/main/install.sh)
```

That's it. The agents are now installed in a `.claude/` folder inside your project.

> **What is `.claude/`?** It's a hidden folder Claude looks for when it opens your
> project. Whatever is in there gets loaded automatically — you don't need to configure
> anything else.

---

## Using the agents

### `/brief` in Claude Code (terminal)

Type `/brief` at the start of a conversation:
```
/brief
```
Claude takes on the role of a product brief facilitator. It asks you focused questions
one at a time and builds up a structured plan as you answer.

### `/brief` in Cowork (desktop app)

The `brief` skill is listed in your available skills. Invoke it by name or just start
describing what you want to build — Claude will recognise the context and guide you.

### `decision-log`

This one runs in the background automatically. When you make a significant call during
a Claude session — a design choice, an architectural decision, a strategic direction —
Claude will offer to log it.

You can also ask Claude directly:
```
Log this as a decision record.
```

---

## Installing in multiple projects

Run the install command from any project folder. Each project gets its own independent
`.claude/` — they don't interfere with each other.

---

## Getting the latest version

To update the agents in an existing project, just re-run the install command from
that project's folder. It replaces the old files with the latest from GitHub.

---

## Want the full suite?

The free agents cover scoping and decision capture. The **MMD Pro** suite adds the
full research-to-build pipeline:

| Agent | What it does |
|---|---|
| `/design-researcher` | Gathers evidence — market research, synthetic interviews, qual/quant synthesis |
| `/ux-strategist` | Frames hypotheses, validates strategy, and steers what to build and why |
| `/designer` | Produces screen specs and component contracts |
| `/data-arch` | Designs database schema and data structures |
| `/engineer` | Builds API routes and server logic |
| `/coder` | Writes production-ready screen code |
| `/tester` | Audits for edge cases, accessibility, and security |
| `/qa` | Full acceptance sign-off before shipping |
| `/build-screen` | Orchestrates design → code → test in one pass |
| `/ship` | Full pipeline from database to shipped feature |

Plus background skills for frontend design, Next.js, shadcn/ui, and Supabase.

Visit [multimodaldesign.com](https://multimodaldesign.com) to find out more.

---

## Questions or issues?

Open an issue on this repo or get in touch at [multimodaldesign.com](https://multimodaldesign.com).
