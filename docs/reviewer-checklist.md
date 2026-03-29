# Reviewer Checklist

Use this checklist before approving a pull request.

- [ ] PR title follows Conventional Commits.
- [ ] If PR is `feat`, title includes `FR-XXX`.
- [ ] If PR is `feat` or `fix`, changelog fragment exists in `changelog/unreleased/`.
- [ ] If PR references `FR-XXX`, matching diary reflection file exists.
- [ ] CI required checks passed.
- [ ] Enforcement parity check: no policy claim depends only on local hooks; merge-critical claims are backed by blocking CI checks.
