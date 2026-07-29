import 'package:flutter/material.dart';
import '../models/models.dart';

class FundraiserWidget extends StatefulWidget {
  final FundraiserPool fundraiser;

  const FundraiserWidget({
    super.key,
    required this.fundraiser,
  });

  @override
  State<FundraiserWidget> createState() => _FundraiserWidgetState();
}

class _FundraiserWidgetState extends State<FundraiserWidget> {
  late double _currentRaised;
  bool _hasContributed = false;

  @override
  void initState() {
    super.initState();
    _currentRaised = widget.fundraiser.raisedAmount;
  }

  void _contributeShare() {
    setState(() {
      _currentRaised += widget.fundraiser.perMemberShare;
      _hasContributed = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Contributed ₹${widget.fundraiser.perMemberShare.toInt()} to ${widget.fundraiser.title}!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_currentRaised / widget.fundraiser.targetAmount).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.savings, color: Theme.of(context).colorScheme.primary, size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'Trip Fund Pool',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '₹${widget.fundraiser.perMemberShare.toInt()} / Member',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.fundraiser.title,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Raised: ₹${_currentRaised.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Goal: ₹${widget.fundraiser.targetAmount.toInt()}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(height: 14),
          // Contributions List
          Text(
            'Member Contributions (${widget.fundraiser.contributions.length})',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 6),
          ...widget.fundraiser.contributions.map((c) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(c.member.avatarUrl),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(c.member.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                  Text(
                    '₹${c.amountContributed.toInt()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: c.isPaid ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    c.isPaid ? Icons.check_circle : Icons.hourglass_top,
                    size: 14,
                    color: c.isPaid ? Colors.green : Colors.orange,
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _hasContributed ? null : _contributeShare,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: Icon(_hasContributed ? Icons.check : Icons.payments, size: 16),
              label: Text(
                _hasContributed ? 'Contributed Share 🎉' : 'Contribute Equal Share (₹${widget.fundraiser.perMemberShare.toInt()})',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
