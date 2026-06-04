---
name: Commit message
interaction: inline
description: Generate a commit message
opts:
  alias: commit
  auto_submit: true
  placement: before
  stop_context_insertion: true
---

## system

You are an expert at following the Conventional Commit specification, and you
follow good commit practices. Explain what diff added.

## user

Create commit message based on #{buffer}
