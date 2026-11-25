"""Illustrative risk prioritization, not proof of exploitation."""
def priority(match_status: str, kev: bool, runtime_signal: bool) -> str:
    if match_status not in {"affected", "not_affected", "unknown"}:
        raise ValueError("invalid match status")
    if match_status == "unknown":
        return "review"
    if match_status == "not_affected":
        return "not_applicable"
    return "high" if kev or runtime_signal else "medium"
