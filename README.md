# Production Diagnostics

This repository contains a curated set of **production-oriented scripts and tools** used to diagnose, analyze, and monitor system and network behavior. The focus is on practical utility in real-world environments. 

Some scripts are preserved for reference and are no longer actively developed.

---

## Overview

The repository is organized as submodules/subtrees representing distinct domains. Each module has its own history and documentation, consolidated here for discoverability and ease of use.

### Goals

* Provide actionable tools for SRE and system diagnostics
* Preserve the history and rationale of each tool
* Serve as a portfolio of practical, production-level scripts

---

## Repository Structure

```
production-diagnostics/
├── java/
│   └── threaddump-analyzer/       # Java thread dump analysis scripts
├── unix/
│   ├── interface_statistic/       # Scripts to monitor network interfaces
│   └── nfs-monitoring/            # Scripts for monitoring NFS mounts and stats
├── networking/
│   ├── tcpdump/		   # Standalone tcpdump helper scripts (dedicated repo)	

```

Each folder contains:

* `README.md` with module-specific documentation
* Scripts or programs relevant to that module
* Notes on usage, assumptions, and limitations

---

## Module Descriptions

### `java/threaddump-analyzer`

Tools to parse and analyze Java thread dumps. Useful for identifying blocked threads, deadlocks, and performance bottlenecks in JVM-based applications.

### `unix/interface_statistic`

Shell/Python scripts to inspect and summarize network interface statistics. Useful for diagnosing packet loss, throughput anomalies, and interface misconfigurations.

### `unix/nfs-monitoring`

Scripts to monitor stale NFS mounts. Helps identify network file system issues.

### `networking/tcpdump`

Standalone tools and scripts for packet capture and analysis. This module lives in a dedicated repository to preserve history and may be linked or used independently. You can find the repository here: [https://github.com/DanielSchwartz1/tcpdump](https://github.com/DanielSchwartz1/tcpdump)

---

## How to use this repository

1. Browse the module directory relevant to your task.
2. Read the module `README.md` for installation, dependencies, and usage instructions.
3. Run scripts directly or integrate into operational workflows as needed.
4. Review notes and examples for assumptions and limitations.

---

## Archival Note

Some of the modules were previously standalone repositories and have been **consolidated as subtrees** here for discoverability. Original repositories are archived and linked from each module when applicable to preserve history and stars.

---

## Contributing

* Fork this repository and create a feature branch
* Add new scripts or improvements to the appropriate module
* Update the module `README.md` with usage and examples
* Submit a pull request

---

## License

MIT License

---
